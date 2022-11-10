part of '../dashboard.dart';

class _DashboardLibraryTab extends StatefulWidget {
  const _DashboardLibraryTab({Key? key}) : super(key: key);

  @override
  State<_DashboardLibraryTab> createState() => _DashboardLibraryTabState();
}

class _DashboardLibraryTabState extends State<_DashboardLibraryTab> {
  @override
  Widget build(BuildContext context) => const Center(
    child: Text(kFeatureUnderDev),
  );
}
