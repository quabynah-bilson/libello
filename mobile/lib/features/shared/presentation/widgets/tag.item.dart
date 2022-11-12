import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';

class TagItem extends StatelessWidget {
  final String label;
  final void Function()? onClosed;

  const TagItem({Key? key, required this.label, this.onClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.disabledColor.withOpacity(kEmphasisLow),
          ),
          color: context.theme.disabledColor.withOpacity(kEmphasisLowest),
          borderRadius: BorderRadius.circular(kRadiusSmall),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.label_important_outline,
              size: 18,
              color: context.colorScheme.onSurface.withOpacity(kEmphasisMedium),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: context.theme.textTheme.caption?.copyWith(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisMedium),
              ),
            ),
            if (onClosed != null) ...{
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onClosed,
                child: Icon(
                  TablerIcons.trash,
                  size: 18,
                  color: context.colorScheme.error.withOpacity(kEmphasisMedium),
                ),
              ),
            },
          ],
        ),
      );
}
