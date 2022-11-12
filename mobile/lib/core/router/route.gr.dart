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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../features/dashboard/presentation/pages/dashboard.dart'
    deferred as _i1;
import '../../features/dashboard/presentation/pages/folder/folder.notes.dart'
    deferred as _i2;
import '../../features/dashboard/presentation/pages/notes/create.note.dart'
    deferred as _i3;
import '../../features/dashboard/presentation/pages/notes/notes.dart'
    deferred as _i4;
import '../../features/shared/domain/entities/folder.dart' as _i7;
import '../../features/shared/domain/entities/note.dart' as _i8;

class LibelloAppRouter extends _i5.RootStackRouter {
  LibelloAppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.DashboardPage(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    FolderNotesRoute.name: (routeData) {
      final args = routeData.argsAs<FolderNotesRouteArgs>();
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.FolderNotesPage(
            key: args.key,
            folder: args.folder,
          ),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    CreateNoteRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CreateNotePage(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    NotesRoute.name: (routeData) {
      final args = routeData.argsAs<NotesRouteArgs>(
          orElse: () => const NotesRouteArgs());
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.NotesPage(
            key: args.key,
            type: args.type,
            status: args.status,
            showAll: args.showAll,
          ),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          DashboardRoute.name,
          path: '/',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          CreateNoteRoute.name,
          path: '/create-note-page',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          NotesRoute.name,
          path: '/notes-page',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.FolderNotesPage]
class FolderNotesRoute extends _i5.PageRouteInfo<FolderNotesRouteArgs> {
  FolderNotesRoute({
    _i6.Key? key,
    required _i7.NoteFolder folder,
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

  final _i6.Key? key;

  final _i7.NoteFolder folder;

  @override
  String toString() {
    return 'FolderNotesRouteArgs{key: $key, folder: $folder}';
  }
}

/// generated route for
/// [_i3.CreateNotePage]
class CreateNoteRoute extends _i5.PageRouteInfo<void> {
  const CreateNoteRoute()
      : super(
          CreateNoteRoute.name,
          path: '/create-note-page',
        );

  static const String name = 'CreateNoteRoute';
}

/// generated route for
/// [_i4.NotesPage]
class NotesRoute extends _i5.PageRouteInfo<NotesRouteArgs> {
  NotesRoute({
    _i6.Key? key,
    _i8.NoteType? type,
    _i8.NoteStatus? status,
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

  final _i6.Key? key;

  final _i8.NoteType? type;

  final _i8.NoteStatus? status;

  final bool showAll;

  @override
  String toString() {
    return 'NotesRouteArgs{key: $key, type: $type, status: $status, showAll: $showAll}';
  }
}
