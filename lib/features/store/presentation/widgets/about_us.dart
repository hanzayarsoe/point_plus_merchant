import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class AboutUs extends StatelessWidget {
  final String? aboutText;
  const AboutUs({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Us', style: Theme.of(context).textTheme.titleMedium),
        AppSpacing.smallSizedBox,
        Text(aboutText ?? '-', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
