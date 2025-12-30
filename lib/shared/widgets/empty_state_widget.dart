import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            AppSpacing.largeSizedBox,
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.smallSizedBox,
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
