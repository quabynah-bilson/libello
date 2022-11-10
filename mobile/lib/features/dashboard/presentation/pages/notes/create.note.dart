import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
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
      _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LoadingOverlay(
          isLoading: _loading,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              const SliverAppBar(title: Text('Create a note')),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        'label',
                        controller: _titleController,
                        validator: (input) =>
                            input == null || input.isEmpty ? 'Required' : null,
                        capitalization: TextCapitalization.sentences,
                      ),
                      AppRoundedButton(
                        text: 'Create note',
                        icon: TablerIcons.note,
                        enabled: !_loading,
                        onTap: _validateAndCreateNote,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _validateAndCreateNote() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (true) {
        Navigator.of(context).push(
          LoginDialog(
            backgroundColor:
                context.colorScheme.background.withOpacity(kEmphasisMedium),
          ),
        );
      } else {
        /*todo => create note */
        var note = Note(
            id: const Uuid().v4(),
            title: _titleController.text.trim(),
            updatedAt: DateTime.now());
        logger.i('note to create => $note');
      }
    }
  }
}
