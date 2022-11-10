part of '../dashboard.dart';

class _DashboardSettingsTab extends StatefulWidget {
  const _DashboardSettingsTab({Key? key}) : super(key: key);

  @override
  State<_DashboardSettingsTab> createState() => _DashboardSettingsTabState();
}

class _DashboardSettingsTabState extends State<_DashboardSettingsTab> {
  @override
  Widget build(BuildContext context) => const Center(
        child: Text(kFeatureUnderDev),
      );
}
