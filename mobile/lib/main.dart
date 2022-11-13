import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libello/core/app.dart';
import 'package:libello/core/constants.dart';
import 'package:new_version/new_version.dart';

import 'core/injector.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// register firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// setup dependencies
  await setupInjector();

  /// setup app versioning
  kAppVersionUpgrader = NewVersion(iOSAppStoreCountry: 'GH');

  /// run application
  runApp(const LibelloApp());
}
