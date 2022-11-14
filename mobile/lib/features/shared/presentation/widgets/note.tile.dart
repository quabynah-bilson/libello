import 'dart:ui';

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
import 'package:libello/features/shared/presentation/widgets/tag.item.dart';
import 'package:string_stats/string_stats.dart';

/// note list item
class NoteTile extends StatefulWidget {
  final Note note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  late var _currentNote = widget.note, _todos = widget.note.todos;
  final _noteCubit = NoteCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNote(_currentNote.id));
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          if (state is NoteSuccess<Note>) {
            _todos = state.data.todos;
            if (state.data.todos.length >= 2) {
              _todos = state.data.todos.getRange(0, 2).toList();
            }
            setState(() => _currentNote = state.data);
          }

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }
        },
        builder: (context, state) => GestureDetector(
          onTap: () =>
              context.router.push(NoteDetailsRoute(note: _currentNote)),
          child: ClipRect(
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Container(
                // height: 200,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                decoration: BoxDecoration(
                  color: widget.note.color == null
                      ? context.colorScheme.surface
                          .withOpacity(kEmphasisNoteBackground)
                      : Color.fromRGBO(
                          widget.note.color!.red,
                          widget.note.color!.green,
                          widget.note.color!.blue,
                          widget.note.color!.opacity),
                  borderRadius: BorderRadius.circular(kRadiusMedium),
                  border: Border.all(
                      color: context.theme.disabledColor
                          .withOpacity(kEmphasisLowest)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    Text(
                      _currentNote.title,
                      style: context.theme.textTheme.subtitle1?.copyWith(
                        color: _generateForegroundColor(),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// description / body
                    if (_currentNote.body.isNotEmpty) ...{
                      Text(
                        '~${wordCount(_currentNote.body)} words',
                        style: context.theme.textTheme.caption?.copyWith(
                          color: _generateForegroundColor()
                              .withOpacity(kEmphasisMedium),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _currentNote.body,
                        style: context.theme.textTheme.subtitle2?.copyWith(
                          color: _generateForegroundColor()
                              .withOpacity(kEmphasisMedium),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    },
                    if (_todos.isNotEmpty) ...{
                      Divider(
                        color: context.theme.disabledColor
                            .withOpacity(kEmphasisLowest),
                      ),
                      AnimationLimiter(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var todo = _todos[index];
                            return AnimationConfiguration.synchronized(
                              duration: kListAnimationDuration,
                              child: SlideAnimation(
                                verticalOffset: kListSlideOffset,
                                child: FadeInAnimation(
                                  child: ListTile(
                                    leading: Icon(
                                      TablerIcons.checklist,
                                      color: todo.completed
                                          ? (_currentNote.color == null
                                              ? context.theme.disabledColor
                                              : _generateForegroundColor()
                                                  .withOpacity(kEmphasisLow))
                                          : _generateForegroundColor(),
                                    ),
                                    minLeadingWidth: 24,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      todo.text,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.theme.textTheme.subtitle2
                                          ?.copyWith(
                                        color: todo.completed
                                            ? (_currentNote.color == null
                                                ? context.theme.disabledColor
                                                : _generateForegroundColor()
                                                    .withOpacity(
                                                        kEmphasisLow))
                                            : _generateForegroundColor(),
                                        decoration: todo.completed
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox.shrink(),
                          itemCount: _todos.length,
                        ),
                      ),
                      Divider(
                        color: context.theme.disabledColor
                            .withOpacity(kEmphasisLowest),
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
                          (index) => TagItem(
                            label: _currentNote.tags[index],
                            color: _generateForegroundColor(),
                          ),
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
                          color: _generateForegroundColor()
                              .withOpacity(kEmphasisMedium),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Color _generateForegroundColor() {
    var generatedColor = context.colorScheme.onSurface;
    if (widget.note.color != null) {
      generatedColor = Colors.black;
    }
    return generatedColor;
  }
}
//Color(0xffa898cf)
