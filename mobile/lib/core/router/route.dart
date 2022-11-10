import 'package:auto_route/auto_route.dart';
import 'package:libello/features/dashboard/presentation/pages/dashboard.dart';
import 'package:libello/features/dashboard/presentation/pages/folder/folder.notes.dart';
import 'package:libello/features/shared/presentation/pages/login.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
  barrierDismissible: true,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: [
    AutoRoute(page: DashboardPage, initial: true),
    AutoRoute(page: FolderNotesPage),
    // AutoRoute(page: LoginDialog, fullscreenDialog: true),
  ],
)
class $LibelloAppRouter {}
