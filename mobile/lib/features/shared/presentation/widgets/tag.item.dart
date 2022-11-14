import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/core/theme.dart';

// todo => fix black colors
class TagItem extends StatelessWidget {
  final String label;
  final Color? color;
  final void Function()? onClosed;

  const TagItem({
    Key? key,
    required this.label,
    this.onClosed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color == null ? context.theme.disabledColor.withOpacity(kEmphasisLow) : color!,
          ),
          color: (color == null ? context.colorScheme.onSurface : color!)
              .withOpacity(kEmphasisLowest),
          borderRadius: BorderRadius.circular(kRadiusSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    TablerIcons.tags,
                    size: 18,
                    color: color == null ? ThemeConfig.kAmber : color!,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: context.theme.textTheme.caption?.copyWith(
                        color: color == null ? context.colorScheme.onSurface : color!),
                  ),
                ],
              ),
            ),
            if (onClosed != null) ...{
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.error.withOpacity(kEmphasisLowest),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(kRadiusSmall),
                    bottomRight: Radius.circular(kRadiusSmall),
                  ),
                ),
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GestureDetector(
                  onTap: onClosed,
                  child: Icon(TablerIcons.trash,
                      size: 18, color: context.colorScheme.error),
                ),
              ),
            },
          ],
        ),
      );
}
