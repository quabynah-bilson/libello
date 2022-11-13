import 'package:auto_route/auto_route.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/modals.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/animated.list.dart';
import 'package:libello/features/shared/presentation/widgets/custom.chip.dart';
import 'package:libello/features/shared/presentation/widgets/folder.tile.dart';
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
  final _noteCubit = NoteCubit(), _updateNoteCubit = NoteCubit();
  NoteFolder? _currentFolder;

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNote(_currentNote.id));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            if (_currentNote.status != NoteStatus.secret) ...{
              IconButton(
                onPressed: () {
                  _currentNote = _currentNote.copyWith(
                      status: _currentNote.status == NoteStatus.archived
                          ? NoteStatus.regular
                          : NoteStatus.archived);
                  _updateNoteCubit.updateNote(_currentNote);
                  context.showSnackBar(
                      _currentNote.status == NoteStatus.archived
                          ? 'Note unarchived'
                          : 'Note has been added to your archives');
                },
                icon: Icon(_currentNote.status == NoteStatus.archived
                    ? TablerIcons.archive_off
                    : TablerIcons.archive),
                tooltip: _currentNote.status == NoteStatus.archived
                    ? 'Unarchive'
                    : 'Archive',
              ),
            },
            IconButton(
              onPressed: _noteCubit.getNoteFolders,
              icon: const Icon(TablerIcons.folder_plus),
              tooltip: 'Add to folder',
            ),
            IconButton(
              onPressed: () async => shareNote(context, _currentNote),
              icon: const Icon(TablerIcons.message_share),
              tooltip: 'Share note',
            ),
            IconButton(
              onPressed: () => _noteCubit.deleteNote(_currentNote.id),
              icon: const Icon(TablerIcons.trash),
              color: context.colorScheme.error,
              tooltip: 'Delete Note',
            ),
          ],
        ),
        body: LoadingOverlay(
          isLoading: _loading,
          child: MultiBlocListener(
            listeners: [
              BlocListener(
                bloc: _noteCubit,
                listener: (context, state) {
                  if (!mounted) return;

                  setState(() => _loading = state is NoteLoading);

                  if (state is NoteError) {
                    context.showSnackBar(state.message,
                        context.colorScheme.error, context.colorScheme.onError);
                  }

                  if (state is NoteSuccess<Note>) {
                    setState(() => _currentNote = state.data);
                    if (state.data.folder != null &&
                        state.data.folder!.isNotEmpty) {
                      _noteCubit.getFolder(state.data.folder!);
                    }
                  }

                  if (state is NoteSuccess<NoteFolder>) {
                    setState(() => _currentFolder = state.data);
                  }

                  if (state is NoteSuccess<String>) {
                    context
                      ..showSnackBar(state.data)
                      ..router.pushAndPopUntil(const DashboardRoute(),
                          predicate: (_) => false);
                  }

                  if (state is NoteSuccess<List<NoteFolder>>) {
                    _showFoldersSheet(state.data);
                  }
                },
              ),
              BlocListener(
                bloc: _updateNoteCubit,
                listener: (context, state) {
                  if (!mounted) return;

                  setState(() => _loading = state is NoteLoading);

                  if (state is NoteError) {
                    context.showSnackBar(state.message);
                  }

                  if (state is NoteSuccess<Note>) {
                    setState(() => _currentNote = state.data);
                  }
                },
              ),
            ],
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

                  /// folder
                  if (_currentFolder != null) ...{
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: CustomChip(
                        onTap: () => context.router
                            .push(FolderNotesRoute(folder: _currentFolder!)),
                        leadingIcon: TablerIcons.folder,
                        label: _currentFolder!.label,
                      ),
                    ),
                  },
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _currentNote.updatedAt.format('d M, y (g:i a)'),
                      style: context.theme.textTheme.caption?.copyWith(
                        color: context.colorScheme.onSurface
                            .withOpacity(kEmphasisMedium),
                      ),
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
                                    _currentNote = _currentNote.copyWith(
                                        updatedAt: DateTime.now());
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
                                          _currentNote = _currentNote.copyWith(
                                              updatedAt: DateTime.now());
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

  /// show a list of folders for current user
  void _showFoldersSheet(List<NoteFolder> folders) async =>
      showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(kRadiusLarge),
            topLeft: Radius.circular(kRadiusLarge),
          ),
        ),
        builder: (context) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, context.mediaQuery.viewInsets.bottom),
          child: SafeArea(
            top: false,
            child: AnimatedColumn(
              animateType: AnimateType.slideUp,
              children: [
                if (folders.isEmpty) ...{
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        TablerIcons.folder_minus,
                        size: context.width * 0.2,
                        color: context.colorScheme.secondary,
                      ),
                      const SizedBox(height: 24),
                      Text('Oops!', style: context.theme.textTheme.headline6),
                      const SizedBox(height: 8),
                      Text(
                        'You have no new folders available',
                        style: context.theme.textTheme.subtitle1?.copyWith(
                          color: context.colorScheme.onBackground
                              .withOpacity(kEmphasisMedium),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FloatingActionButton.extended(
                        heroTag: kHomeFabTag,
                        onPressed: () {
                          context.router.pop();
                          doAfterDelay(_createFolder);
                        },
                        icon: const Icon(TablerIcons.folder_plus),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text('Create one'),
                        ),
                        backgroundColor: context.colorScheme.secondary,
                        foregroundColor: context.colorScheme.onSecondary,
                      ),
                    ],
                  ),
                } else ...{
                  Center(
                    child: Text(
                      'Your Folders',
                      style: context.theme.textTheme.subtitle1
                          ?.copyWith(color: context.colorScheme.secondary),
                    ),
                  ),
                  ...folders
                      .map(
                        (folder) => FolderTile(
                          folder: folder,
                          onTap: () {
                            context.router.pop();
                            doAfterDelay(() {
                              _currentNote =
                                  _currentNote.copyWith(folder: folder.id);
                              _updateNoteCubit.updateNote(_currentNote);
                            });
                          },
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 40),
                  FloatingActionButton.extended(
                    heroTag: kHomeFabTag,
                    onPressed: () {
                      context.router.pop();
                      doAfterDelay(_createFolder);
                    },
                    icon: const Icon(TablerIcons.folder_plus),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Create one'),
                    ),
                    backgroundColor: context.colorScheme.secondary,
                    foregroundColor: context.colorScheme.onSecondary,
                  ),
                },
              ],
            ),
          ),
        ),
      );

  /// create folder
  void _createFolder() async {
    var noteFolder = await createFolder(context);
    if (noteFolder != null) {
      _noteCubit.createFolder(noteFolder);
    }
  }
}
