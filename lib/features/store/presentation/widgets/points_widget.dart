import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant/core/constants/app_assets.dart';

class PointsWidget extends StatelessWidget {
  final int? points;
  final int? promoPoints;
  final TextStyle? pointTextStyle;
  final TextStyle? promoPointTextStyle;
  const PointsWidget({
    super.key,
    required this.points,
    this.promoPoints,
    this.pointTextStyle,
    this.promoPointTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        SvgPicture.asset(
          AppAssets.pointIcon,
          width: 16,
          height: 16,
          fit: BoxFit.cover,
        ),
        if (points != null)
          Flexible(
            child: Text(
              '$points pts',
              style:
                  pointTextStyle ??
                  Theme.of(context).textTheme.labelSmall!.copyWith(
                    decoration: (promoPoints != null && promoPoints! > 0)
                        ? TextDecoration.lineThrough
                        : null,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (promoPoints != null && promoPoints! > 0)
          Flexible(
            child: Text(
              '$promoPoints pts',
              style:
                  promoPointTextStyle ?? Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
