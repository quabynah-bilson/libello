import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libello/core/app.dart';
import 'package:upgrader/upgrader.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Only call clearSavedSettings() during testing to reset internal values.
  if (!kReleaseMode) await Upgrader.clearSavedSettings();

  /// register firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const LibelloApp());
}
