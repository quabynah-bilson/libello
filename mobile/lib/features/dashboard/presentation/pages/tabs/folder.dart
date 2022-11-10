part of '../dashboard.dart';

class _DashboardFolderTab extends StatefulWidget {
  const _DashboardFolderTab({Key? key}) : super(key: key);

  @override
  State<_DashboardFolderTab> createState() => _DashboardFolderTabState();
}

class _DashboardFolderTabState extends State<_DashboardFolderTab> {
  @override
  Widget build(BuildContext context) => const Center(
      child: Text(kFeatureUnderDev),
    );
}
