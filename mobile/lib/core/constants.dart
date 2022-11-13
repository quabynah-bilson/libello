import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

/// for debugging
final logger = Logger();
bool kIsReleased = kReleaseMode;

/// app constants
const kAppName = 'Libello.';
const kAppDesc = 'A note taking mobile application for pros';
final kAppDevTeam =
    'Created by Quabynah Codelabs LLC © ${DateTime.now().year} & inspired by @LayoDesigns (Dribbble)';
const kAppLogo = 'assets/logo.png';
// reference: https://lottiefiles.com/110457-notes-document
const kAppLoadingAnimation = 'assets/notes_doc.json';
const kFeatureUnderDev =
    'This feature will be available in the next major release';
const kScanNoteTitle = 'Scan your note';
const kScanNoteDescription = 'Create notes from your camera in real-time';
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
const kListAnimationDuration = Duration(milliseconds: 550);
const kGridAnimationDuration = Duration(milliseconds: 850);
const kContentAnimationDuration = Duration(seconds: 1);
const kListSlideOffset = 100.0;
const kHomeFabTag = 'libello-home';
const kOptionsFabTag = 'libello-options-sheet';

/// local storage preferences (keys)
const kUsernameKey = 'libello-username-key';
const kEmailAddressKey = 'libello-email-key';
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
