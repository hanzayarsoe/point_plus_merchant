import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class SeeAll extends StatelessWidget {
  final VoidCallback onPressed;
  const SeeAll({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Text(
                'See All',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Icon(LucideIcons.arrowRight, size: AppSpacing.seeAllIconSize),
            ],
          ),
        ),
      ],
    );
  }
}
