import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/core/theme.dart';
import 'package:libello/features/dashboard/presentation/widgets/quick.tip.card.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/custom.chip.dart';
import 'package:libello/features/shared/presentation/widgets/filled.button.dart';
import 'package:libello/features/shared/presentation/widgets/folder.tile.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';

part 'tabs/folder.dart';

part 'tabs/home.dart';

part 'tabs/library.dart';

part 'tabs/settings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _selectedIndex = 0;
  late final _pages = <Widget>[
    const _DashboardHomeTab(),
    const _DashboardLibraryTab(),
    const _DashboardFolderTab(),
    const _DashboardSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context,
        statusBarBrightness: _selectedIndex == 0
            ? context.invertedThemeBrightness
            : context.theme.brightness);

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const CreateNoteRoute()),
        child: const Icon(TablerIcons.plus),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(TablerIcons.home_2), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? Icons.interests_sharp
                  : Icons.interests_outlined),
              label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 2 ? Icons.folder : Icons.folder_outlined),
              label: 'Folders'),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3
                  ? Icons.settings
                  : Icons.settings_outlined),
              label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
