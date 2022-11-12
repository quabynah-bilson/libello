import 'package:auto_route/auto_route.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/animated.list.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/tag.item.dart';

/// note details
class NoteDetailsPage extends StatefulWidget {
  final Note note;

  const NoteDetailsPage({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late var _currentNote = widget.note, _loading = true;
  final _noteCubit = NoteCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNote(_currentNote.id));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async => shareNote(context, _currentNote),
              icon: const Icon(TablerIcons.message_share),
            ),
            IconButton(
              onPressed: () => _noteCubit.deleteNote(_currentNote.id),
              icon: const Icon(TablerIcons.trash),
              color: context.colorScheme.error,
            ),
          ],
        ),
        body: LoadingOverlay(
          isLoading: _loading,
          child: BlocListener(
            bloc: _noteCubit,
            listener: (context, state) {
              if (!mounted) return;

              setState(() => _loading = state is NoteLoading);

              if (state is NoteError) {
                context.showSnackBar(state.message);
              }
              if (state is NoteSuccess<Note>) {
                setState(() => _currentNote = state.data);
              }

              if (state is NoteSuccess<String>) {
                context
                  ..showSnackBar(state.data)
                  ..router.pushAndPopUntil(const DashboardRoute(),
                      predicate: (_) => false);
              }
            },
            child: AnimationLimiter(
              child: AnimatedListView(
                animateType: AnimateType.slideLeft,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                children: [
                  Text(
                    _currentNote.title,
                    style: context.theme.textTheme.headline4
                        ?.copyWith(color: context.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _currentNote.updatedAt.format('d M, y (g:i a)'),
                    style: context.theme.textTheme.overline?.copyWith(
                      color: context.colorScheme.onSurface
                          .withOpacity(kEmphasisMedium),
                    ),
                  ),

                  /// labels
                  if (_currentNote.tags.isNotEmpty) ...{
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'Labels',
                        style: context.theme.textTheme.subtitle1
                            ?.copyWith(color: context.colorScheme.secondary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Wrap(
                        runSpacing: 12,
                        spacing: 8,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: kListAnimationDuration,
                          childAnimationBuilder: (child) => SlideAnimation(
                            horizontalOffset: kListSlideOffset,
                            child: FadeInAnimation(child: child),
                          ),
                          children: _currentNote.tags
                              .map((e) => TagItem(label: e))
                              .toList(),
                        ),
                      ),
                    ),
                  },

                  /// description
                  if (_currentNote.body.isNotEmpty) ...{
                    Text(
                      _currentNote.body,
                      style: context.theme.textTheme.bodyText1?.copyWith(
                          color: context.colorScheme.onBackground
                              .withOpacity(kEmphasisMedium)),
                    ),
                  },

                  /// todos
                  if (_currentNote.todos.isNotEmpty) ...{
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'To-Do',
                        style: context.theme.textTheme.subtitle1
                            ?.copyWith(color: context.colorScheme.secondary),
                      ),
                    ),
                    AnimationLimiter(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: context.height * 0.1),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var todo = _currentNote.todos[index];
                          return AnimationConfiguration.synchronized(
                            duration: kListAnimationDuration,
                            child: SlideAnimation(
                              horizontalOffset: kListSlideOffset,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    todo = todo.copyWith(
                                        completed: !todo.completed,
                                        updatedAt: DateTime.now());
                                    _currentNote.todos[index] = todo;
                                    _noteCubit.updateNote(_currentNote);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: todo.completed,
                                        activeColor:
                                            context.theme.disabledColor,
                                        onChanged: (checked) {
                                          todo = todo.copyWith(
                                              completed: checked,
                                              updatedAt: DateTime.now());
                                          _currentNote.todos[index] = todo;
                                          _noteCubit.updateNote(_currentNote);
                                        },
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          todo.text,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: context
                                              .theme.textTheme.subtitle2
                                              ?.copyWith(
                                            color: todo.completed
                                                ? context.theme.disabledColor
                                                : context.colorScheme.onSurface,
                                            decoration: todo.completed
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox.shrink(),
                        itemCount: _currentNote.todos.length,
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: kHomeFabTag,
          onPressed: () =>
              context.router.push(UpdateNoteRoute(note: _currentNote)),
          label: const Text('Edit note'),
          icon: const Icon(TablerIcons.edit),
          foregroundColor: context.colorScheme.onSecondary,
          backgroundColor: context.colorScheme.secondary,
        ),
      );
}
