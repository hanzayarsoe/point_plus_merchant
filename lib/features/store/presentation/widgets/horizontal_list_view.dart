import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/store/presentation/widgets/home_title_bar.dart';

class HorizontalListview extends StatelessWidget {
  final String? widgetTitle;
  final VoidCallback? seeAllAction;
  final double gap;
  final List<Widget> widgets;
  const HorizontalListview({
    super.key,
    this.widgetTitle,
    this.seeAllAction,
    required this.gap,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.extraSmallSpacing,
      children: [
        if (widgetTitle != null && seeAllAction != null)
          HomeTitleBar(title: widgetTitle!, seeAll: seeAllAction!),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(spacing: gap, children: widgets),
        ),
      ],
    );
  }
}
