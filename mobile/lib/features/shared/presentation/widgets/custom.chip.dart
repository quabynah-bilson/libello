import 'package:flutter/material.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';

class CustomChip extends StatelessWidget {
  final void Function() onTap;
  final IconData leadingIcon;
  final String label;

  const CustomChip({
    Key? key,
    required this.onTap,
    required this.leadingIcon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(kEmphasisLowest),
        border: Border.all(
            color:
                context.theme.disabledColor.withOpacity(kEmphasisLowest)),
        borderRadius: BorderRadius.circular(kRadiusLarge),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(leadingIcon,
              size: context.theme.textTheme.subtitle1?.fontSize,
              color: context.colorScheme.primary
                  .withOpacity(kEmphasisMedium)),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.theme.textTheme.subtitle1?.copyWith(
              color: context.colorScheme.primary
                  .withOpacity(kEmphasisMedium),
            ),
          ),
        ],
      ),
    ),
  );
}
