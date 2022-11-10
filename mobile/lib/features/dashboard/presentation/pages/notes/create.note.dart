import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/pages/login.dart';
import 'package:libello/features/shared/presentation/widgets/app.text.field.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/rounded.button.dart';
import 'package:uuid/uuid.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  var _loading = false;
  final _formKey = GlobalKey<FormState>(),
      _titleController = TextEditingController(),
      _authCubit = AuthCubit(),
      _noteCubit = NoteCubit();

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
        },
        child: Scaffold(
          body: LoadingOverlay(
            isLoading: _loading,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                const SliverAppBar(title: Text('Create a note')),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 16),
                    child: Text(
                      'Complete the details to create a new note',
                      style: context.theme.textTheme.subtitle1?.copyWith(
                        color: context.colorScheme.onBackground
                            .withOpacity(kEmphasisMedium),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextField(
                            "What's on your mind?",
                            controller: _titleController,
                            maxLength: 50,
                            enabled: !_loading,
                            validator: (input) => input == null || input.isEmpty
                                ? 'Required'
                                : null,
                            capitalization: TextCapitalization.sentences,
                          ),
                          StreamBuilder<bool>(
                              stream: _authCubit.loginStatus,
                              initialData: false,
                              builder: (context, snapshot) {
                                return AppRoundedButton(
                                  text: 'Create note',
                                  icon: TablerIcons.note,
                                  enabled: !_loading,
                                  onTap: () => _validateAndCreateNote(
                                      snapshot.hasData && snapshot.data!),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _validateAndCreateNote(bool loggedIn) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (!loggedIn) {
        var user = await Navigator.of(context).push(
          LoginDialog(
            _authCubit,
            backgroundColor:
                context.colorScheme.background.withOpacity(kEmphasisMedium),
          ),
        );
        if (user is User) {
          // ignore: use_build_context_synchronously
          context.showSnackBar(
              'Signed in as ${user.displayName}! Proceeding to create your note...');
          _createNote();
        }
      } else {
        _createNote();
      }
    }
  }

  void _createNote() {
    var note = Note(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        updatedAt: DateTime.now());
    logger.i('note to create => $note');
    _noteCubit.createNote(note);
  }
}
