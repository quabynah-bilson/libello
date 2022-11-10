import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';

class FilledButtonWithIcon extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final IconData? icon;

  const FilledButtonWithIcon({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.symmetric(
            horizontal: BorderSide(
                color:
                    context.theme.disabledColor.withOpacity(kEmphasisLowest)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// label
            Text(
              label.toUpperCase(),
              style: context.theme.textTheme.button?.copyWith(
                  color:
                      context.colorScheme.onSurface.withOpacity(kEmphasisLow)),
            ),

            /// icon
            GestureDetector(
              onTap: onTap,
              child: Material(
                color: context.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(kRadiusLarge),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      icon ?? TablerIcons.plus,
                      size: 20,
                      color: context.colorScheme.onSurface
                          .withOpacity(kEmphasisMedium),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
