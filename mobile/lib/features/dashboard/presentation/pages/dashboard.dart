import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/custom.chip.dart';
import 'package:libello/features/shared/presentation/widgets/filled.button.dart';
import 'package:libello/features/shared/presentation/widgets/folder.tile.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/note.tile.dart';
import 'package:lottie/lottie.dart';

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
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder(
        bloc: context.read<NoteCubit>(),
        builder: (context, state) {
          if (state is NoteLoading) return const SizedBox.shrink();
          return FloatingActionButton(
            heroTag: kHomeFabTag,
            onPressed: () => context.router.push(const CreateNoteRoute()),
            child: const Icon(TablerIcons.plus),
          );
        },
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          _selectedIndex == 0 ? TablerIcons.home_eco : TablerIcons.home_x,
          _selectedIndex == 1
              ? Icons.interests_sharp
              : Icons.interests_outlined,
          _selectedIndex == 2 ? Icons.folder : Icons.folder_outlined,
          _selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
        ],
        activeIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: context.colorScheme.surface,
        activeColor: context.colorScheme.secondary,
      ),
    );
  }
}
