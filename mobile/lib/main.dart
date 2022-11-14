import 'package:camera/camera.dart';
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
  kAppVersionUpgrader = NewVersion(
      androidId: 'io.qcodelabs.libello', iOSId: 'io.qcodelabs.libello');

  /// get cameras
  kCameras = await availableCameras();

  /// run application
  runApp(const LibelloApp());
}
