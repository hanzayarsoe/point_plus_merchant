import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';

class ProfileCardRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? rightText;
  final bool? bottomBorder;
  final VoidCallback onTap;
  final Widget? customRightWidget;
  const ProfileCardRow({
    super.key,
    required this.icon,
    required this.label,
    this.rightText,
    this.bottomBorder,
    required this.onTap,
    this.customRightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.normalBorderRadiusCircular,
      child: Row(
        children: [
          CustomIcon(
            icon: Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: AppSpacing.extraSmallPadding,
            paddingColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          SizedBox(width: AppSpacing.defaultSpacing),
          Expanded(
            child: Container(
              padding: AppSpacing.profileCardRowPadding,
              decoration: BoxDecoration(
                border: (bottomBorder ?? false)
                    ? Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHigh,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (rightText != null) ...[
                    Text(
                      rightText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: AppSpacing.extraSmallSpacing),
                  ],
                  customRightWidget ?? Icon(LucideIcons.chevronRight, size: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
