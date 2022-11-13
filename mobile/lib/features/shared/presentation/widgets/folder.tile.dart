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
  final bool readOnly;

  const FolderTile({
    Key? key,
    required this.folder,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  final _noteCubit = NoteCubit(), _folderCubit = NoteCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _folderCubit,
        listener: (context, state) {
          if (!mounted) return;

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }
        },
        child: BlocBuilder(
          bloc: _noteCubit,
          builder: (context, state) => ListTile(
            onTap: widget.onTap ??
                () => context.router
                    .push(FolderNotesRoute(folder: widget.folder)),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.primary.withOpacity(kEmphasisLowest),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                TablerIcons.folder,
                color: context.colorScheme.primary,
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
                          style: TextStyle(color: context.colorScheme.primary),
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
            trailing: widget.readOnly ? null : IconButton(
              onPressed: () => _folderCubit.deleteFolder(widget.folder.id),
              icon: const Icon(TablerIcons.trash),
            ),
          ),
        ),
      );
}
