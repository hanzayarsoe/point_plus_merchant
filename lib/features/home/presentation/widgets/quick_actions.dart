import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.quickActions});

  final List<({IconData icon, VoidCallback onPressed, String title})>
  quickActions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: quickActions.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.largeSpacing,
        mainAxisSpacing: AppSpacing.largeSpacing,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return InkWell(
          onTap: action.onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppSpacing.smallCircularBorderRadius,
              color: Theme.of(context).colorScheme.surfaceBright,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.mediumSpacing,
              children: [
                Icon(
                  action.icon,
                  size: 30,
                  color: Theme.of(context).colorScheme.surface,
                ),
                Text(
                  action.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
