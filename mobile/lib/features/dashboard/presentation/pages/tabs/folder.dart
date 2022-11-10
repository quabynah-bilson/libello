part of '../dashboard.dart';

class _DashboardFolderTab extends StatefulWidget {
  const _DashboardFolderTab({Key? key}) : super(key: key);

  @override
  State<_DashboardFolderTab> createState() => _DashboardFolderTabState();
}

class _DashboardFolderTabState extends State<_DashboardFolderTab> {
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

    ),
  );
}
