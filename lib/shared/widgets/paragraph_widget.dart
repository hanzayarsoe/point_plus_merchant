import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/profile/presentation/widgets/bullet_text.dart';

class ParagraphWidget extends StatelessWidget {
  final String title;
  final List<String> content;
  const ParagraphWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.smallSpacing,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Column(
          spacing: AppSpacing.smallSpacing,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content.map((str) {
            return BulletText(text: str);
          }).toList(),
        ),
      ],
    );
  }
}
