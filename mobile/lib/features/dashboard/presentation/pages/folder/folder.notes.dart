import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';

class FolderNotesPage extends StatefulWidget {
  final NoteFolder folder;

  const FolderNotesPage({Key? key, required this.folder}) : super(key: key);

  @override
  State<FolderNotesPage> createState() => _FolderNotesPageState();
}

class _FolderNotesPageState extends State<FolderNotesPage> {
  var _loading = true;

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      await Future.delayed(kSampleDelay);
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _loading,
        child: CustomScrollView(
          slivers: [
            /// app bar
            SliverAppBar(
              title: Text(widget.folder.label),
              actions: [
                IconButton(
                  onPressed: () => context.showSnackBar(kFeatureUnderDev),
                  icon: const Icon(TablerIcons.edit_circle),
                ),
              ],
            ),

            /// content
          ],
        ),
      ),
    );
  }
}
