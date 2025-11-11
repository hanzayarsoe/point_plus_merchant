import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/presentation/widgets/points_widget.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';

class ItemCard extends StatelessWidget {
  final ItemEntity item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 160;
    final double imageHeight = 120;
    return SizedBox(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppSpacing.smallCircularBorderRadius,
            child: CustomCachedNetworkImage(
              profileUrl: item.itemImageUrl,
              width: cardWidth,
              height: imageHeight,
              isProfile: false,
            ),
          ),
          AppSpacing.extraSmallSizedBox,
          Text(
            item.name ?? '',
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          PointsWidget(
            points: item.requiredPoints ?? 0,
            promoPoints: item.promotionPoints,
          ),
        ],
      ),
    );
  }
}
