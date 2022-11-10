

import 'package:libello/core/constants.dart';
import 'package:upgrader/upgrader.dart';

class LibelloUpgraderMessages extends UpgraderMessages {
  @override
  String get buttonTitleUpdate => 'Update now...';

  @override
  String? message(UpgraderMessage messageKey) {
    switch (messageKey) {
      case UpgraderMessage.body:
        return 'en A new version of {{appName}} is available!';
      case UpgraderMessage.buttonTitleIgnore:
        return 'en Ignore';
      case UpgraderMessage.buttonTitleLater:
        return 'en Later';
      case UpgraderMessage.buttonTitleUpdate:
        return 'en Update Now';
      case UpgraderMessage.prompt:
        return 'en Want to update?';
      case UpgraderMessage.releaseNotes:
        return 'en Release Notes';
      case UpgraderMessage.title:
        return 'en Update App?';
    }
    return super.message(messageKey);
  }

  @override
  String get body => 'A new version of $kAppName is available! Version 0.0.1 is now available-you have {{currentInstalledVersion}}.';
}