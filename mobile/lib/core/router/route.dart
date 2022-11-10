import 'package:auto_route/auto_route.dart';
import 'package:libello/features/dashboard/presentation/pages/dashboard.dart';
import 'package:libello/features/dashboard/presentation/pages/folder/folder.notes.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/create.note.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/notes.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
  barrierDismissible: true,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: [
    AutoRoute(page: DashboardPage, initial: true),
    AutoRoute(page: FolderNotesPage),
    AutoRoute(page: CreateNotePage),
    AutoRoute(page: NotesPage),
  ],
)
class $LibelloAppRouter {}
