part of '../dashboard.dart';

class _DashboardSettingsTab extends StatefulWidget {
  const _DashboardSettingsTab({Key? key}) : super(key: key);

  @override
  State<_DashboardSettingsTab> createState() => _DashboardSettingsTabState();
}

class _DashboardSettingsTabState extends State<_DashboardSettingsTab> {
  var _loading = true;

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) => LoadingOverlay(
        isLoading: _loading,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(),
          ],
        ),
      );

  /*
  FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) => GestureDetector(
                  onTap: () => _showLicenses(
                      snapshot.hasData ? snapshot.data?.version : null),
                  child: const Center(
                    child: Text(kFeatureUnderDev),
                  ),
                ),
              ),
  * */

  void _showLicenses([String? version]) => Navigator.of(context).push(
        RevealRoute(
          page: LicensePage(
            applicationName: kAppName,
            applicationIcon: LottieBuilder.asset(
              kAppLoadingAnimation,
              repeat: false,
              height: context.height * 0.2,
            ),
            applicationLegalese: kAppDevTeam,
            applicationVersion: version ?? '0.0.0-alpha',
          ),
          maxRadius: context.height * 1.2,
          centerAlignment: Alignment.center,
          // centerOffset: Offset(context.width * 0.8, context.height * 0.1),
        ),
      );
}
