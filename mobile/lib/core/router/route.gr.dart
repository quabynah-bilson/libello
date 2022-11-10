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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/material.dart' as _i5;

import '../../features/dashboard/presentation/pages/dashboard.dart'
    deferred as _i1;
import '../../features/dashboard/presentation/pages/folder/folder.notes.dart'
    deferred as _i2;
import '../../features/dashboard/presentation/pages/notes/create.note.dart'
    deferred as _i3;
import '../../features/shared/domain/entities/folder.dart' as _i7;

class LibelloAppRouter extends _i4.RootStackRouter {
  LibelloAppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.DashboardPage(),
        ),
        transitionsBuilder: _i4.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    FolderNotesRoute.name: (routeData) {
      final args = routeData.argsAs<FolderNotesRouteArgs>();
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.FolderNotesPage(
            key: args.key,
            folder: args.folder,
          ),
        ),
        transitionsBuilder: _i4.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    CreateNoteRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CreateNotePage(),
        ),
        transitionsBuilder: _i4.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          DashboardRoute.name,
          path: '/',
          deferredLoading: true,
        ),
        _i4.RouteConfig(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          deferredLoading: true,
        ),
        _i4.RouteConfig(
          CreateNoteRoute.name,
          path: '/create-note-page',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i4.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.FolderNotesPage]
class FolderNotesRoute extends _i4.PageRouteInfo<FolderNotesRouteArgs> {
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
class CreateNoteRoute extends _i4.PageRouteInfo<void> {
  const CreateNoteRoute()
      : super(
          CreateNoteRoute.name,
          path: '/create-note-page',
        );

  static const String name = 'CreateNoteRoute';
}
