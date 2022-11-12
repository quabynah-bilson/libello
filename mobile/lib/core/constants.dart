import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

/// for debugging
final logger = Logger();

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
