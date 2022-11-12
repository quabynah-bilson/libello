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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../features/dashboard/presentation/pages/dashboard.dart'
    deferred as _i1;
import '../../features/dashboard/presentation/pages/folder/folder.notes.dart'
    deferred as _i2;
import '../../features/dashboard/presentation/pages/notes/create.note.dart'
    deferred as _i3;
import '../../features/dashboard/presentation/pages/notes/note.details.dart'
    deferred as _i5;
import '../../features/dashboard/presentation/pages/notes/notes.dart'
    deferred as _i4;
import '../../features/shared/domain/entities/folder.dart' as _i8;
import '../../features/shared/domain/entities/note.dart' as _i9;

class LibelloAppRouter extends _i6.RootStackRouter {
  LibelloAppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.DashboardPage(),
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    FolderNotesRoute.name: (routeData) {
      final args = routeData.argsAs<FolderNotesRouteArgs>();
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.FolderNotesPage(
            key: args.key,
            folder: args.folder,
          ),
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    CreateNoteRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CreateNotePage(),
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    NotesRoute.name: (routeData) {
      final args = routeData.argsAs<NotesRouteArgs>(
          orElse: () => const NotesRouteArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.NotesPage(
            key: args.key,
            type: args.type,
            status: args.status,
            showAll: args.showAll,
          ),
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    NoteDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<NoteDetailsRouteArgs>();
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.NoteDetailsPage(
            key: args.key,
            note: args.note,
          ),
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          DashboardRoute.name,
          path: '/',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          CreateNoteRoute.name,
          path: '/create-note-page',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          NotesRoute.name,
          path: '/notes-page',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          NoteDetailsRoute.name,
          path: '/note-details-page',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i6.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.FolderNotesPage]
class FolderNotesRoute extends _i6.PageRouteInfo<FolderNotesRouteArgs> {
  FolderNotesRoute({
    _i7.Key? key,
    required _i8.NoteFolder folder,
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

  final _i7.Key? key;

  final _i8.NoteFolder folder;

  @override
  String toString() {
    return 'FolderNotesRouteArgs{key: $key, folder: $folder}';
  }
}

/// generated route for
/// [_i3.CreateNotePage]
class CreateNoteRoute extends _i6.PageRouteInfo<void> {
  const CreateNoteRoute()
      : super(
          CreateNoteRoute.name,
          path: '/create-note-page',
        );

  static const String name = 'CreateNoteRoute';
}

/// generated route for
/// [_i4.NotesPage]
class NotesRoute extends _i6.PageRouteInfo<NotesRouteArgs> {
  NotesRoute({
    _i7.Key? key,
    _i9.NoteType? type,
    _i9.NoteStatus? status,
    bool showAll = false,
  }) : super(
          NotesRoute.name,
          path: '/notes-page',
          args: NotesRouteArgs(
            key: key,
            type: type,
            status: status,
            showAll: showAll,
          ),
        );

  static const String name = 'NotesRoute';
}

class NotesRouteArgs {
  const NotesRouteArgs({
    this.key,
    this.type,
    this.status,
    this.showAll = false,
  });

  final _i7.Key? key;

  final _i9.NoteType? type;

  final _i9.NoteStatus? status;

  final bool showAll;

  @override
  String toString() {
    return 'NotesRouteArgs{key: $key, type: $type, status: $status, showAll: $showAll}';
  }
}

/// generated route for
/// [_i5.NoteDetailsPage]
class NoteDetailsRoute extends _i6.PageRouteInfo<NoteDetailsRouteArgs> {
  NoteDetailsRoute({
    _i7.Key? key,
    required _i9.Note note,
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

  final _i7.Key? key;

  final _i9.Note note;

  @override
  String toString() {
    return 'NoteDetailsRouteArgs{key: $key, note: $note}';
  }
}
