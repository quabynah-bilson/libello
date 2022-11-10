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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../features/dashboard/presentation/pages/dashboard.dart'
    deferred as _i1;
import '../../features/dashboard/presentation/pages/folder/folder.notes.dart'
    deferred as _i2;
import '../../features/shared/domain/entities/folder.dart' as _i5;

class LibelloAppRouter extends _i3.RootStackRouter {
  LibelloAppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.DashboardPage(),
        ),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
    FolderNotesRoute.name: (routeData) {
      final args = routeData.argsAs<FolderNotesRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.FolderNotesPage(
            key: args.key,
            folder: args.folder,
          ),
        ),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: true,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          DashboardRoute.name,
          path: '/',
          deferredLoading: true,
        ),
        _i3.RouteConfig(
          FolderNotesRoute.name,
          path: '/folder-notes-page',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i3.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.FolderNotesPage]
class FolderNotesRoute extends _i3.PageRouteInfo<FolderNotesRouteArgs> {
  FolderNotesRoute({
    _i4.Key? key,
    required _i5.NoteFolder folder,
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

  final _i4.Key? key;

  final _i5.NoteFolder folder;

  @override
  String toString() {
    return 'FolderNotesRouteArgs{key: $key, folder: $folder}';
  }
}
