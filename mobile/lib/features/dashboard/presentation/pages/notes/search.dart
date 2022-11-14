import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/app.text.field.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/note.tile.dart';
import 'package:lottie/lottie.dart';

/// search page
/// reference: https://itnext.io/full-text-search-in-flutter-with-algolia-firestore-cloud-functions-with-optimization-54004d727ad1
class NoteSearchPage extends StatefulWidget {
  const NoteSearchPage({Key? key}) : super(key: key);

  @override
  State<NoteSearchPage> createState() => _NoteSearchPageState();
}

class _NoteSearchPageState extends State<NoteSearchPage> {
  var _loading = false,
      _filteredNotes = List<Note>.empty(growable: true),
      _notes = List<Note>.empty();
  final _noteCubit = NoteCubit(), _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is NoteLoading);

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }

          if (state is NoteSuccess<List<Note>>) {
            setState(() => _notes = state.data);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              AppTransparentTextField(
                  label: 'Search a note...',
                  controller: _searchController,
                  autofocus: true,
                  action: TextInputAction.search,
                  style: context.theme.textTheme.headline4,
                  onChanged: (query) {
                    if (query == null || query.isEmpty || query.length < 3) {
                      _filteredNotes.clear();
                    } else {
                      /// perform manual search
                      /// fixme: v2: optimize with algolia, cloud functions & optimization
                      _filteredNotes = _notes
                          .where((element) =>
                              element.title
                                  .toLowerCase()
                                  .contains(query.trim().toLowerCase()) ||
                              element.body
                                  .toLowerCase()
                                  .contains(query.trim().toLowerCase()) ||
                              element.todos
                                  .map((e) => e.text)
                                  .where((element) => element
                                      .toLowerCase()
                                      .contains(query.trim().toLowerCase()))
                                  .isNotEmpty)
                          .toList();
                    }
                    setState(() {});
                  }),
              Expanded(
                child: LoadingOverlay(
                  isLoading: _loading,
                  child: _filteredNotes.isEmpty &&
                          _searchController.text.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LottieBuilder.asset(
                                kAppLoadingAnimation,
                                repeat: false,
                                height: context.width * 0.4,
                                width: context.width * 0.4,
                              ),
                              Text(
                                'No notes found with this query',
                                style: context.theme.textTheme.subtitle2,
                              ),
                            ],
                          ),
                        )
                      : MasonryGridView(
                          padding: EdgeInsets.fromLTRB(
                              24, 20, 24, context.height * 0.15),
                          gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _filteredNotes.length == 1 ? 1 : 2),
                          shrinkWrap: true,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 12,
                          children: _filteredNotes
                              .map(
                                (note) => AnimationConfiguration.staggeredGrid(
                                  position: _filteredNotes.indexOf(note),
                                  columnCount: _filteredNotes.length == 1 ? 1 : 2,
                                  duration: kListAnimationDuration,
                                  child: SlideAnimation(
                                      verticalOffset: kListSlideOffset,
                                      child: FadeInAnimation(
                                          child: NoteTile(
                                              key: ValueKey(note.id),
                                              note: note))),
                                ),
                              )
                              .toList(),
                        ),
                ),
              )
            ],
          ),
        ),
      );
}
