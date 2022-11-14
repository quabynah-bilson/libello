// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/modals.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/core/theme.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/scan.note.dart';
import 'package:libello/features/dashboard/presentation/pages/notes/search.dart';
import 'package:libello/features/dashboard/presentation/widgets/quick.tip.card.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/animated.row.dart';
import 'package:libello/features/shared/presentation/widgets/custom.chip.dart';
import 'package:libello/features/shared/presentation/widgets/filled.button.dart';
import 'package:libello/features/shared/presentation/widgets/folder.tile.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/note.tile.dart';
import 'package:libello/features/shared/presentation/widgets/reveal.route.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  void initState() {
    super.initState();
    doAfterDelay(_checkAppVersion);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: _pages[_selectedIndex],
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder(
        bloc: context.read<NoteCubit>(),
        builder: (context, state) {
          if (state is NoteLoading) return const SizedBox.shrink();
          return FloatingActionButton(
            heroTag: kHomeFabTag,
            onPressed: () async {
              await context.router.push(const CreateNoteRoute());
              context.read<NoteCubit>().getNotes();
            },
            backgroundColor: context.colorScheme.secondary,
            foregroundColor: context.colorScheme.onSecondary,
            child: const Icon(TablerIcons.notes),
          );
        },
      ),
      bottomNavigationBar: StreamBuilder<bool>(
          stream: context.read<AuthCubit>().loginStatus,
          initialData: false,
          builder: (context, snapshot) {
            return AnimatedBottomNavigationBar(
              icons: [
                _selectedIndex == 0 ? TablerIcons.home_eco : TablerIcons.home_x,
                _selectedIndex == 1
                    ? Icons.interests_sharp
                    : Icons.interests_outlined,
                _selectedIndex == 2 ? Icons.folder : Icons.folder_outlined,
                _selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
              ],
              activeIndex: _selectedIndex,
              onTap: (index) async {
                if (index == 3 && snapshot.hasData && !snapshot.data!) {
                  var user = await showLoginSheet(context);
                  if (user is User && mounted) {
                    setState(() => _selectedIndex = index);
                  }
                } else {
                  setState(() => _selectedIndex = index);
                }
              },
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              backgroundColor: context.colorScheme.surface,
              activeColor: context.colorScheme.primary,
              inactiveColor: context.theme.disabledColor,
            );
          }),
    );

  /// check for new app updates
  void _checkAppVersion() async {
    await kAppVersionUpgrader?.showAlertIfNecessary(context: context);
    // var versionStatus = await kAppVersionUpgrader?.getVersionStatus();
    // if (versionStatus != null) {
    //   kAppVersionUpgrader?.showUpdateDialog(context: context, versionStatus: versionStatus);
    // }
  }
}
