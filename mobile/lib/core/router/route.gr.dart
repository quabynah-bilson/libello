// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../features/dashboard/presentation/pages/dashboard.dart'
    deferred as _i1;
import '../../features/dashboard/presentation/pages/folder/folder.notes.dart'
    deferred as _i2;
import '../../features/dashboard/presentation/pages/notes/create.note.dart'
    deferred as _i3;
import '../../features/dashboard/presentation/pages/notes/note.details.dart'
    deferred as _i6;
import '../../features/dashboard/presentation/pages/notes/notes.dart'
    deferred as _i5;
import '../../features/dashboard/presentation/pages/notes/scan.note.dart'
    deferred as _i7;
import '../../features/dashboard/presentation/pages/notes/update.note.dart'
    deferred as _i4;
import '../../features/shared/domain/entities/folder.dart' as _i10;
import '../../features/shared/domain/entities/note.dart' as _i11;

class LibelloAppRouter extends _i8.RootStackRouter {
  LibelloAppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.DashboardPage(),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    FolderNotesRoute.name: (routeData) {
      final args = routeData.argsAs<FolderNotesRouteArgs>();
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.FolderNotesPage(
            key: args.key,
            folder: args.folder,
          ),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    CreateNoteRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CreateNotePage(),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.UpdateNotePage(
            key: args.key,
            note: args.note,
          ),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    NotesRoute.name: (routeData) {
      final args = routeData.argsAs<NotesRouteArgs>(
          orElse: () => const NotesRouteArgs());
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.NotesPage(
            key: args.key,
            type: args.type,
            status: args.status,
            title: args.title,
            showAll: args.showAll,
            showNotesWithTodos: args.showNotesWithTodos,
          ),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    NoteDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<NoteDetailsRouteArgs>();
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.NoteDetailsPage(
            key: args.key,
            note: args.note,
          ),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    ScanNoteRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.ScanNotePage(),
        ),
        transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          DashboardRoute.name,
          path: '/',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          CreateNoteRoute.name,
          path: '/create-note-page',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          UpdateNoteRoute.name,
          path: '/update-note-page',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          NotesRoute.name,
          path: '/notes-page',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          NoteDetailsRoute.name,
          path: '/note-details-page',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          ScanNoteRoute.name,
          path: '/scan-note-page',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.FolderNotesPage]
class FolderNotesRoute extends _i8.PageRouteInfo<FolderNotesRouteArgs> {
  FolderNotesRoute({
    _i9.Key? key,
    required _i10.NoteFolder folder,
  }) : super(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          args: FolderNotesRouteArgs(
            key: key,
            folder: folder,
          ),
        );

  static const String name = 'FolderNotesRoute';
}

class FolderNotesRouteArgs {
  const FolderNotesRouteArgs({
    this.key,
    required this.folder,
  });

  final _i9.Key? key;

  final _i10.NoteFolder folder;

  @override
  String toString() {
    return 'FolderNotesRouteArgs{key: $key, folder: $folder}';
  }
}

/// generated route for
/// [_i3.CreateNotePage]
class CreateNoteRoute extends _i8.PageRouteInfo<void> {
  const CreateNoteRoute()
      : super(
          CreateNoteRoute.name,
          path: '/create-note-page',
        );

  static const String name = 'CreateNoteRoute';
}

/// generated route for
/// [_i4.UpdateNotePage]
class UpdateNoteRoute extends _i8.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i9.Key? key,
    required _i11.Note note,
  }) : super(
          UpdateNoteRoute.name,
          path: '/update-note-page',
          args: UpdateNoteRouteArgs(
            key: key,
            note: note,
          ),
        );

  static const String name = 'UpdateNoteRoute';
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.note,
  });

  final _i9.Key? key;

  final _i11.Note note;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [_i5.NotesPage]
class NotesRoute extends _i8.PageRouteInfo<NotesRouteArgs> {
  NotesRoute({
    _i9.Key? key,
    _i11.NoteType? type,
    _i11.NoteStatus? status,
    String title = 'My notes',
    bool showAll = false,
    bool showNotesWithTodos = false,
  }) : super(
          NotesRoute.name,
          path: '/notes-page',
          args: NotesRouteArgs(
            key: key,
            type: type,
            status: status,
            title: title,
            showAll: showAll,
            showNotesWithTodos: showNotesWithTodos,
          ),
        );

  static const String name = 'NotesRoute';
}

class NotesRouteArgs {
  const NotesRouteArgs({
    this.key,
    this.type,
    this.status,
    this.title = 'My notes',
    this.showAll = false,
    this.showNotesWithTodos = false,
  });

  final _i9.Key? key;

  final _i11.NoteType? type;

  final _i11.NoteStatus? status;

  final String title;

  final bool showAll;

  final bool showNotesWithTodos;

  @override
  String toString() {
    return 'NotesRouteArgs{key: $key, type: $type, status: $status, title: $title, showAll: $showAll, showNotesWithTodos: $showNotesWithTodos}';
  }
}

/// generated route for
/// [_i6.NoteDetailsPage]
class NoteDetailsRoute extends _i8.PageRouteInfo<NoteDetailsRouteArgs> {
  NoteDetailsRoute({
    _i9.Key? key,
    required _i11.Note note,
  }) : super(
          NoteDetailsRoute.name,
          path: '/note-details-page',
          args: NoteDetailsRouteArgs(
            key: key,
            note: note,
          ),
        );

  static const String name = 'NoteDetailsRoute';
}

class NoteDetailsRouteArgs {
  const NoteDetailsRouteArgs({
    this.key,
    required this.note,
  });

  final _i9.Key? key;

  final _i11.Note note;

  @override
  String toString() {
    return 'NoteDetailsRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [_i7.ScanNotePage]
class ScanNoteRoute extends _i8.PageRouteInfo<void> {
  const ScanNoteRoute()
      : super(
          ScanNoteRoute.name,
          path: '/scan-note-page',
        );

  static const String name = 'ScanNoteRoute';
}
