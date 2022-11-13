import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

/// folder list item
class FolderTile extends StatefulWidget {
  final NoteFolder folder;
  final void Function()? onTap;

  const FolderTile({
    Key? key,
    required this.folder,
    this.onTap,
  }) : super(key: key);

  @override
  State<FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  final _noteCubit = NoteCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _noteCubit,
        builder: (context, state) => ListTile(
          onTap: widget.onTap ??
              () =>
                  context.router.push(FolderNotesRoute(folder: widget.folder)),
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.secondary.withOpacity(kEmphasisLowest),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              TablerIcons.folder,
              color: context.colorScheme.secondary,
            ),
          ),
          title: Text(widget.folder.label),
          subtitle: state is NoteSuccess<List<Note>>
              ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${state.data.where((element) => element.folder == widget.folder.id).length}',
                        style: TextStyle(color: context.colorScheme.secondary),
                      ),
                      const TextSpan(text: ' notes /'),
                      TextSpan(
                          text:
                              ' updated ${timeago.format(widget.folder.updatedAt)}'),
                    ],
                  ),
                  style: TextStyle(
                      color: context.colorScheme.onBackground
                          .withOpacity(kEmphasisMedium)),
                )
              : Text(
                  '...',
                  style: TextStyle(
                      color: context.colorScheme.onBackground
                          .withOpacity(kEmphasisMedium)),
                ),
          trailing: const Icon(TablerIcons.chevron_right),
        ),
      );
}
