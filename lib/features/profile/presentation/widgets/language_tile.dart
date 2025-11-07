import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class LanguageTile extends StatelessWidget {
  final bool isSelected;
  final String localeCode;
  final VoidCallback onTap;
  const LanguageTile({
    super.key,
    required this.isSelected,
    required this.localeCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.languageCardPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: AppSpacing.smallCircularBorderRadius,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceContainerLow,
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: SvgPicture.asset(
                localeCode == 'en' ? AppAssets.enIcon : AppAssets.myIcon,
                width: 26,
                height: 26,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppSpacing.smallSpacing),
            Text(
              localeCode == 'en' ? 'English' : 'Myanmar (မြန်မာ)',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            if (isSelected)
              Container(
                padding: AppSpacing.extraSmallPadding,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.check,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
