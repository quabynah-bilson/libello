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
        child: const Center(
          child: Text(kFeatureUnderDev),
        ),
      );
}
