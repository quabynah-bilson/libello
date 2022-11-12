import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libello/core/app.dart';

import 'core/injector.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// register firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// setup dependencies
  await setupInjector();

  runApp(const LibelloApp());
}
