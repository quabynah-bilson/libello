import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_palette/flutter_palette.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/modals.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/app.text.field.dart';
import 'package:libello/features/shared/presentation/widgets/filled.button.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/rounded.button.dart';
import 'package:libello/features/shared/presentation/widgets/tag.item.dart';

/// update note
class UpdateNotePage extends StatefulWidget {
  final Note note;

  const UpdateNotePage({Key? key, required this.note}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  late var _loading = false,
      _showTodosUI = true,
      _generatedColors = List<RgbColor>.empty(growable: true);
  late final _formKey = GlobalKey<FormState>(),
      _titleController = TextEditingController(text: widget.note.title),
      _descController = TextEditingController(text: widget.note.body),
      _authCubit = AuthCubit(),
      _noteCubit = NoteCubit(),
      _todos = widget.note.todos,
      _labels = widget.note.tags;
  late RgbColor _selectedNoteColor = RgbColor.fromColor(
      widget.note.color == null
          ? context.colorScheme.surface
          : Color.fromRGBO(widget.note.color!.red, widget.note.color!.green,
              widget.note.color!.blue, widget.note.color!.opacity));

  @override
  void initState() {
    super.initState();
    doAfterDelay(_generateColorPalette);
  }

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is NoteLoading);

          if (state is NoteError) {
            context.showSnackBar(state.message);
          }
          if (state is NoteSuccess<Note>) {
            context
              ..showSnackBar('Note created successfully')
              ..router.pop();
          }

          if (state is NoteSuccess<String>) {
            context
              ..showSnackBar(state.data)
              ..router.pushAndPopUntil(const DashboardRoute(),
                  predicate: (_) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: _showOptionsSheet,
                icon: const Icon(TablerIcons.dots),
                tooltip: 'More options',
              ),
            ],
          ),
          body: LoadingOverlay(
            isLoading: _loading,
            child: AnimationLimiter(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  /// title, description & labels
                  SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// title
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                            child: AppTransparentTextField(
                              label: 'Title*',
                              controller: _titleController,
                              style: context.theme.textTheme.headline4
                                  ?.copyWith(
                                      color: context.colorScheme.onBackground),
                              validator: (input) =>
                                  input == null || input.isEmpty
                                      ? 'Required'
                                      : null,
                              capitalization: TextCapitalization.sentences,
                              action: TextInputAction.next,
                              inputType: TextInputType.text,
                            ),
                          ),

                          /// description
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: AppTransparentTextField(
                              label: 'What do you wish to accomplish today?',
                              controller: _descController,
                              style: context.theme.textTheme.bodyText1
                                  ?.copyWith(
                                      color: context.colorScheme.onBackground),
                              capitalization: TextCapitalization.sentences,
                              action: TextInputAction.newline,
                              inputType: TextInputType.multiline,
                              maxLines: 3,
                            ),
                          ),

                          /// labels
                          if (_labels.isNotEmpty) ...{
                            FilledButtonWithIcon(
                              label: 'Labels',
                              onTap: _showAddLabelSheet,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              child: Wrap(
                                runSpacing: 12,
                                spacing: 8,
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: kListAnimationDuration,
                                  childAnimationBuilder: (child) =>
                                      SlideAnimation(
                                    horizontalOffset: kListSlideOffset,
                                    child: FadeInAnimation(child: child),
                                  ),
                                  children: _labels
                                      .map((e) => TagItem(
                                            label: e,
                                            color: widget.note.color == null
                                                ? context.colorScheme.surface
                                                : Color.fromRGBO(
                                                    widget.note.color!.red,
                                                    widget.note.color!.green,
                                                    widget.note.color!.blue,
                                                    widget.note.color!.opacity),
                                            onClosed: () => setState(() =>
                                                _labels.removeWhere(
                                                    (element) => e == element)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                  ),

                  /// todos
                  if (_showTodosUI) ...{
                    SliverToBoxAdapter(
                      child: FilledButtonWithIcon(
                        label: 'Todos',
                        onTap: _showAddTodoSheet,
                      ),
                    ),
                    if (_todos.isEmpty) ...{
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: AnimatedColumn(
                            children: [
                              Icon(TablerIcons.checklist,
                                  size: 48,
                                  color: context.colorScheme.secondaryContainer),
                              const SizedBox(height: 16),
                              Text(
                                'You have no todos for this note',
                                style: context.theme.textTheme.subtitle2
                                    ?.copyWith(
                                        color:
                                            context.colorScheme.onBackground),
                              ),
                            ],
                          ),
                        ),
                      ),
                    } else ...{
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => ListTile(
                              title: Text(
                                _todos[index].text,
                                style: TextStyle(
                                  decoration: _todos[index].completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: _todos[index].completed
                                      ? context.theme.disabledColor
                                      : null,
                                ),
                              ),
                              leading: Checkbox(
                                value: _todos[index].completed,
                                activeColor: context.theme.disabledColor,
                                onChanged: (completed) {
                                  var todo = _todos[index];
                                  todo = todo.copyWith(completed: completed);
                                  setState(() => _todos[index] = todo);
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    setState(() => _todos.removeAt(index)),
                                icon: const Icon(TablerIcons.trash),
                                color: context.colorScheme.error,
                              ),
                            ),
                            childCount: _todos.length,
                          ),
                        ),
                      ),
                    },
                    SliverToBoxAdapter(
                        child: SizedBox(height: context.height * 0.15)),
                  },
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                  stream: _authCubit.loginStatus,
                  initialData: false,
                  builder: (context, snapshot) => FloatingActionButton.extended(
                    heroTag: kHomeFabTag,
                    onPressed: () => _validateAndUpdateNote(
                        snapshot.hasData && snapshot.data!),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Update note'),
                    ),
                    icon: const Icon(TablerIcons.notes),
                    enableFeedback: true,
                    isExtended: !_loading,
                    backgroundColor: context.colorScheme.secondary,
                    foregroundColor: context.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _validateAndUpdateNote(bool loggedIn) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (loggedIn) {
        _updateNote();
      } else {
        var user = await showLoginSheet(context);
        if (user is User) {
          // ignore: use_build_context_synchronously
          context.showSnackBar(
              'Signed in as ${user.displayName}! Proceeding to create your note...');
          _updateNote();
        }
      }
    }
  }

  /// create a new note
  void _updateNote() {
    var note = widget.note.copyWith(
      title: _titleController.text.trim(),
      body: _descController.text.trim(),
      tags: _labels,
      todos: _showTodosUI ? _todos : List<NoteTodo>.empty(),
      updatedAt: DateTime.now(),
      color: NoteRgbColor(
          red: _selectedNoteColor.red,
          green: _selectedNoteColor.green,
          blue: _selectedNoteColor.blue,
          opacity: _selectedNoteColor.opacity),
    );
    logger.i('note to update => $note');
    _noteCubit.updateNote(note);
  }

  /// show options for the note
  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(kRadiusLarge),
          topLeft: Radius.circular(kRadiusLarge),
        ),
      ),
      builder: (context) => StatefulBuilder(
          builder: (context, setter) => AnimationLimiter(
                child: AnimatedContainer(
                  duration: kListAnimationDuration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  color: context.colorScheme.surface,
                  child: SafeArea(
                    top: false,
                    child: AnimatedColumn(
                      animateType: AnimateType.slideUp,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_generatedColors.isNotEmpty) ...{
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: kListAnimationDuration,
                              childAnimationBuilder: (child) => SlideAnimation(
                                horizontalOffset: kListSlideOffset,
                                child: FadeInAnimation(child: child),
                              ),
                              children: _generatedColors
                                  .map((rgbColor) => _buildColorPicker(
                                      rgbColor,
                                      () => setter(
                                          () => _selectedNoteColor = rgbColor)))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                        },
                        ListTile(
                          title: Text(
                            'Delete',
                            style:
                                TextStyle(color: context.colorScheme.onSurface),
                          ),
                          leading: Icon(TablerIcons.trash,
                              color: context.colorScheme.onSurface),
                          onTap: () {
                            context.router.pop();
                            _noteCubit.deleteNote(widget.note.id);
                          },
                        ),
                        ListTile(
                          title: Text(
                            '${_showTodosUI ? 'Remove' : 'Add'} Todo list',
                            style:
                                TextStyle(color: context.colorScheme.onSurface),
                          ),
                          leading: Icon(TablerIcons.checklist,
                              color: context.colorScheme.onSurface),
                          onTap: () {
                            setState(() => _showTodosUI = !_showTodosUI);
                            context.router.pop();
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Add a Label',
                            style:
                                TextStyle(color: context.colorScheme.onSurface),
                          ),
                          leading: Icon(TablerIcons.tags,
                              color: context.colorScheme.onSurface),
                          onTap: () {
                            context.router.pop();
                            doAfterDelay(_showAddLabelSheet, 500);
                          },
                        ),
                        const SizedBox(height: 16),
                        FloatingActionButton.extended(
                          heroTag: kOptionsFabTag,
                          onPressed: context.router.pop,
                          label: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text('Dismiss'),
                          ),
                          enableFeedback: true,
                          backgroundColor: context.colorScheme.onSurface,
                          foregroundColor: context.colorScheme.surface,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  /// add label
  void _showAddLabelSheet() async {
    String? label;
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
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                24, 16, 24, context.mediaQuery.viewInsets.bottom),
            child: AnimatedColumn(
              animateType: AnimateType.slideUp,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a new label',
                  style: context.theme.textTheme.subtitle1
                      ?.copyWith(color: context.colorScheme.secondaryContainer),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  'Label',
                  onChange: (input) => label = input?.trim(),
                  capitalization: TextCapitalization.words,
                  maxLength: 12,
                  suffixIcon: Icon(
                    Icons.label,
                    color: context.colorScheme.secondaryContainer,
                  ),
                  autofocus: true,
                ),
                SafeArea(
                  top: false,
                  child: AppRoundedButton(
                    text: 'Add',
                    onTap: () {
                      if (label != null && label!.isNotEmpty) {
                        setState(() => _labels.add(label ??= 'Custom Tag'));
                      }
                      context.router.pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// add to-do item
  void _showAddTodoSheet() async {
    String? label;
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
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              24, 16, 24, context.mediaQuery.viewInsets.bottom),
          child: AnimatedColumn(
            animateType: AnimateType.slideUp,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add a todo item',
                style: context.theme.textTheme.subtitle1
                    ?.copyWith(color: context.colorScheme.secondaryContainer),
              ),
              const SizedBox(height: 24),
              AppTextField(
                'Item',
                onChange: (input) => label = input?.trim(),
                capitalization: TextCapitalization.sentences,
                suffixIcon: const Icon(TablerIcons.checkup_list),
                autofocus: true,
              ),
              SafeArea(
                top: false,
                child: AppRoundedButton(
                  text: 'Add',
                  onTap: () {
                    if (label != null && label!.isNotEmpty) {
                      setState(() => _todos.add(
                            NoteTodo(
                              text: label ??= 'Custom Tag',
                              completed: false,
                              updatedAt: DateTime.now(),
                            ),
                          ));
                    }
                    context.router.pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// color picker widget
  Widget _buildColorPicker(RgbColor rgbColor, void Function() onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: context.width * 0.15,
          width: context.width * 0.15,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color:
                    context.theme.disabledColor.withOpacity(kEmphasisLowest)),
          ),
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              /// background color
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(rgbColor.red, rgbColor.green,
                        rgbColor.blue, rgbColor.opacity),
                  ),
                ),
              ),

              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: _selectedNoteColor == rgbColor ? 1 : 0,
                  duration: kListAnimationDuration,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black54),
                    alignment: Alignment.center,
                    child: const Icon(TablerIcons.check, color: Colors.white),
                  ),
                ),
              ),

              if (_selectedNoteColor == rgbColor) ...{
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black54),
                    alignment: Alignment.center,
                    child: const Icon(TablerIcons.check, color: Colors.white),
                  ),
                ),
              },
            ],
          ),
        ),
      );

  /// generate color palette
  void _generateColorPalette() async {
    var palette = ColorPalette.random(5, minBrightness: 100);
    _generatedColors = palette.colors
        .map((e) => RgbColor(e.red, e.green, e.blue, e.alpha))
        .toList();
    if (mounted) setState(() {});
  }
}
