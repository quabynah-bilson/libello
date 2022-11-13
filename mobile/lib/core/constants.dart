import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/widgets/app.text.field.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../features/shared/presentation/widgets/animated.column.dart';

/// for debugging
final logger = Logger();
bool kIsReleased = kReleaseMode;

/// app constants
const kAppName = 'Libello.';
const kAppDesc = 'A note taking mobile application for pros';
const kAppLogo = 'assets/logo.png';
const kAppLoadingAnimation = 'assets/notes_doc.json';
const kFeatureUnderDev = 'Feature under development';
const kScanNoteTitle = 'Scan your note';
const kScanNoteDescription =
    'Transfer your note with an image capture directly from your camera';
const kDrawNoteTitle = 'Draw your note';
const kDrawNoteDescription = 'Beautifully design your note with art effects';
const kAuthRequired = 'Sign in to access your notes';

/// radius
const kRadiusSmall = 8.0;
const kRadiusMedium = 16.0;
const kRadiusLarge = 40.0;

/// opacity
const kEmphasisHigh = 0.85;
const kEmphasisMedium = 0.67;
const kEmphasisLow = 0.38;
const kEmphasisLowest = 0.1;

/// animations & transitions
const kSampleDelay = Duration(seconds: 2);
const kListAnimationDuration = Duration(milliseconds: 850);
const kContentAnimationDuration = Duration(seconds: 1);
const kListSlideOffset = 100.0;
const kHomeFabTag = 'libello-home';
const kOptionsFabTag = 'libello-options-sheet';

/// local storage preferences (keys)
const kUsernameKey = 'libello-username-key';
const kUserIdKey = 'libello-id-key';

/// share
Future<void> shareNote(BuildContext context, Note note) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(note.title,
      subject: note.title,
      sharePositionOrigin: Platform.isIOS && context.size!.width >= 650
          ? box!.localToGlobal(Offset.zero) & box.size
          : null);
}

/// create folder sheet
/// reference: https://stackoverflow.com/questions/52414629/how-to-update-state-of-a-modalbottomsheet-in-flutter
Future<NoteFolder?> createFolder(BuildContext context) async {
  final controller = TextEditingController();
  NoteFolder? folder;
  var selectedFolderType = FolderType.public;

  return await showModalBottomSheet<NoteFolder>(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              24, 16, 24, context.mediaQuery.viewInsets.bottom),
          child: AnimatedColumn(
            animateType: AnimateType.slideUp,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create your new folder',
                style: context.theme.textTheme.subtitle1
                    ?.copyWith(color: context.colorScheme.secondary),
              ),
              const SizedBox(height: 24),
              AppTextField(
                'Label',
                controller: controller,
                onChange: (input) {
                  folder ??= input == null || input.isEmpty
                      ? null
                      : NoteFolder(
                          id: '', label: '', updatedAt: DateTime.now());
                  folder = folder?.copyWith(label: input?.trim());
                },
                capitalization: TextCapitalization.words,
              ),
              AppDropdownField(
                label: 'Type',
                values: FolderType.values.map((e) => e.name).toList(),
                onSelected: (type) => setState(() {
                  selectedFolderType = FolderType.values
                      .firstWhere((element) => element.name == type);
                  folder = folder?.copyWith(type: selectedFolderType);
                }),
                current: selectedFolderType.name,
              ),
              const SizedBox(height: 40),
              SafeArea(
                top: false,
                child: FloatingActionButton.extended(
                  heroTag: kHomeFabTag,
                  onPressed: () => context.router.pop(
                      folder?.label == null || folder!.label.isEmpty
                          ? null
                          : folder),
                  icon: const Icon(TablerIcons.folder),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Create'),
                  ),
                  backgroundColor: context.colorScheme.secondary,
                  foregroundColor: context.colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
