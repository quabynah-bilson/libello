import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

/// folder list item
class FolderTile extends StatelessWidget {
  final NoteFolder folder;

  const FolderTile({
    Key? key,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => context.router.push(FolderNotesRoute(folder: folder)),
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
        title: Text(folder.label),
        subtitle: Text.rich(
          TextSpan(
            children: [
              // todo => add notes count here
              TextSpan(
                text: '${Random().nextInt(200)}',
                style: TextStyle(color: context.colorScheme.secondary),
              ),
              const TextSpan(text: ' notes /'),
              TextSpan(text: ' updated ${timeago.format(folder.updatedAt)}'),
            ],
          ),
          style: TextStyle(
              color: context.colorScheme.onBackground
                  .withOpacity(kEmphasisMedium)),
        ),
        trailing: const Icon(TablerIcons.chevron_right),
      );
}
