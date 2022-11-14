import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/note.tile.dart';
import 'package:lottie/lottie.dart';

class NotesPage extends StatefulWidget {
  final String title;
  final NoteType? type;
  final NoteStatus? status;
  final bool showAll;
  final bool showNotesWithTodos;

  const NotesPage({
    Key? key,
    this.type,
    this.status,
    this.title = 'My notes',
    this.showAll = false,
    this.showNotesWithTodos = false,
  })  : assert(status != null || type != null || showAll || showNotesWithTodos),
        super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  var _loading = false, _notes = List<Note>.empty();
  late final _noteCubit = context.read<NoteCubit>();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() =>
        widget.status != null && widget.status == NoteStatus.archived
            ? _noteCubit.getArchivedNotes()
            : _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocListener(
          bloc: _noteCubit,
          listener: (context, state) {
            if (!mounted) return;

            setState(() => _loading = state is NoteLoading);

            if (state is NoteError) {
              context.showSnackBar(state.message);
            }

            if (state is NoteSuccess<List<Note>>) {
              if (widget.showAll) _notes = state.data;
              if (widget.showNotesWithTodos) {
                _notes =
                    state.data.where((note) => note.todos.isNotEmpty).toList();
              }
              if (widget.type != null) {
                _notes = state.data
                    .where((element) => element.type == widget.type)
                    .toList();
              }
              if (widget.status != null) {
                _notes = state.data
                    .where((element) => element.status == widget.status)
                    .toList();
              }
              setState(() {});
            }
          },
          child: LoadingOverlay(
            isLoading: _loading,
            child: AnimationLimiter(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  if (_notes.isEmpty) ...{
                    SliverFillRemaining(
                      child: Center(
                        child: AnimatedColumn(
                          animateType: AnimateType.slideUp,
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
                          ],
                        ),
                      ),
                    ),
                  } else ...{
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                      sliver: SliverMasonryGrid(
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount:  _notes.length == 1 ? 1 : 2,
                            duration: kListAnimationDuration,
                            child: SlideAnimation(
                              verticalOffset: kListSlideOffset,
                              child: FadeInAnimation(
                                child: NoteTile(
                                    key: ValueKey(_notes[index].id),
                                    note: _notes[index]),
                              ),
                            ),
                          ),
                          childCount: _notes.length,
                        ),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: kHomeFabTag,
          onPressed: () => context.router.push(const CreateNoteRoute()),
          backgroundColor: context.colorScheme.secondary,
          foregroundColor: context.colorScheme.onSecondary,
          icon: const Icon(TablerIcons.notes),
          label: const Text('New note'),
        ),
      );
}
