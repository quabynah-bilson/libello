import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/tag.item.dart';
import 'package:string_stats/string_stats.dart';

import '../../../../core/router/route.gr.dart';

/// note list item
class NoteTile extends StatefulWidget {
  final Note note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  late var _currentNote = widget.note;
  final _noteCubit = NoteCubit();

  @override
  Widget build(BuildContext context) => BlocConsumer(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          if (state is NoteSuccess<Note>) {
            setState(() => _currentNote = state.data);
          }

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () =>
                context.router.push(NoteDetailsRoute(note: _currentNote)),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  // height: 200,
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface
                        .withOpacity(kEmphasisMedium),
                    borderRadius: BorderRadius.circular(kRadiusMedium),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title
                      Text(
                        _currentNote.title,
                        style: context.theme.textTheme.subtitle1
                            ?.copyWith(color: context.colorScheme.secondary),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (_currentNote.body.isNotEmpty) ...{
                        const SizedBox(height: 8),
                        Text(
                          '~${wordCount(_currentNote.body)} words',
                          style: context.theme.textTheme.caption?.copyWith(
                            color: context.colorScheme.onSurface
                                .withOpacity(kEmphasisMedium),
                          ),
                        ),
                      },

                      /// description / body
                      Divider(
                        height: 24,
                        color: context.theme.disabledColor
                            .withOpacity(kEmphasisLowest),
                      ),
                      if (_currentNote.body.isNotEmpty) ...{
                        Text(
                          _currentNote.body,
                          style: context.theme.textTheme.subtitle2?.copyWith(
                            color: context.colorScheme.onSurface
                                .withOpacity(kEmphasisMedium),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      },
                      if (_currentNote.todos.isNotEmpty) ...{
                        AnimationLimiter(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var todo = _currentNote.todos[index];
                              return AnimationConfiguration.synchronized(
                                duration: kListAnimationDuration,
                                child: SlideAnimation(
                                  horizontalOffset: kListSlideOffset,
                                  child: FadeInAnimation(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: todo.completed,
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
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: context
                                                .theme.textTheme.subtitle2
                                                ?.copyWith(
                                              color: todo.completed
                                                  ? context.theme.disabledColor
                                                  : context
                                                      .colorScheme.onSurface,
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
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemCount: _currentNote.todos.length,
                          ),
                        ),
                      },

                      /// tag
                      if (_currentNote.tags.isNotEmpty) ...{
                        const SizedBox(height: 24),
                        Wrap(
                          runSpacing: 12,
                          spacing: 8,
                          children: List.generate(
                            _currentNote.tags.length,
                            (index) => TagItem(label: _currentNote.tags[index]),
                          ),
                        ),
                      },

                      /// timestamp
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          _currentNote.updatedAt.format('d M, y (g:i a)'),
                          style: context.theme.textTheme.overline?.copyWith(
                            color: context.colorScheme.onSurface
                                .withOpacity(kEmphasisMedium),
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
      );
}
