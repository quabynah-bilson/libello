import 'package:flutter/material.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';

/// show quick tips on dashboard
class QuickTipCard extends StatelessWidget {
  final IconData topLeftIcon;
  final IconData topRightIcon;
  final String title;
  final String subtitle;
  final void Function() onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const QuickTipCard({
    Key? key,
    required this.topLeftIcon,
    required this.topRightIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: context.width * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(kRadiusSmall),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// top
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    topLeftIcon,
                    color: foregroundColor ?? context.colorScheme.onSecondary,
                  ),
                  Icon(
                    topRightIcon,
                    color: foregroundColor ?? context.colorScheme.onSecondary,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.subtitle1?.copyWith(
                        color:
                            foregroundColor ?? context.colorScheme.onSecondary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.theme.textTheme.subtitle2?.copyWith(
                        color: foregroundColor ??
                            context.colorScheme.onSecondary
                                .withOpacity(kEmphasisMedium),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
