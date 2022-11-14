import 'package:auto_route/auto_route.dart';
import 'package:libello/features/dashboard/presentation/pages/dashboard.dart';
import 'package:libello/features/dashboard/presentation/pages/folder/folder.notes.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/create.note.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/note.details.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/notes.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/scan.note.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/update.note.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
  barrierDismissible: true,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: [
    AutoRoute(page: DashboardPage, initial: true),
    AutoRoute(page: FolderNotesPage),
    AutoRoute(page: CreateNotePage),
    AutoRoute(page: UpdateNotePage),
    AutoRoute(page: NotesPage),
    AutoRoute(page: NoteDetailsPage),
    AutoRoute(page: ScanNotePage),
  ],
)
class $LibelloAppRouter {}
