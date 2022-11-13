import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/note.tile.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/router/route.gr.dart';

class FolderNotesPage extends StatefulWidget {
  final NoteFolder folder;

  const FolderNotesPage({Key? key, required this.folder}) : super(key: key);

  @override
  State<FolderNotesPage> createState() => _FolderNotesPageState();
}

class _FolderNotesPageState extends State<FolderNotesPage> {
  var _loading = true, _notes = List<Note>.empty();
  final _noteCubit = NoteCubit();

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
            setState(() => _notes = state.data
                .where((element) => element.folder == widget.folder.id)
                .toList());
          }
        },
        child: AnimationLimiter(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.folder.label),
              actions: [
                IconButton(
                  onPressed: () => context.showSnackBar(kFeatureUnderDev),
                  icon: const Icon(TablerIcons.edit),
                ),
              ],
            ),
            body: LoadingOverlay(
              isLoading: _loading,
              child: _notes.isEmpty
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
                            'You have no recent notes',
                            style: context.theme.textTheme.subtitle2,
                          ),
                          const SizedBox(height: 40),
                          FloatingActionButton.extended(
                            heroTag: kHomeFabTag,
                            onPressed: () =>
                                context.router.push(const CreateNoteRoute()),
                            label: const Text('Create a new note'),
                            icon: const Icon(TablerIcons.notes),
                            backgroundColor: context.colorScheme.secondary,
                            foregroundColor: context.colorScheme.onSecondary,
                          ),
                        ],
                      ),
                    )
                  : MasonryGridView(
                      padding: EdgeInsets.fromLTRB(
                          24, 16, 24, context.height * 0.15),
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 12,
                      children: _notes
                          .map(
                            (note) => AnimationConfiguration.staggeredGrid(
                              position: _notes.indexOf(note),
                              columnCount: 2,
                              duration: kListAnimationDuration,
                              child: SlideAnimation(
                                  verticalOffset: kListSlideOffset,
                                  child: FadeInAnimation(
                                      child: NoteTile(note: note))),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        ),
      );
}
