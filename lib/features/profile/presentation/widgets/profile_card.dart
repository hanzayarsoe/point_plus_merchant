import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class ProfileCard extends StatelessWidget {
  final String? title;
  final List<Widget>? profileCardRows;
  const ProfileCard({super.key, this.profileCardRows, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.profileCardPadding,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        borderRadius: AppSpacing.normalBorderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(title!, style: Theme.of(context).textTheme.titleMedium),
            AppSpacing.extraSmallSizedBox,
          ],
          if (profileCardRows != null) ...profileCardRows!,
        ],
      ),
    );
  }
}
