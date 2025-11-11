import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/presentation/widgets/points_widget.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';

class ItemDetailsPage extends StatelessWidget {
  final ItemEntity item;
  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Details', automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: AppSpacing.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: AppSpacing.smallCircularBorderRadius,
                  child: CustomCachedNetworkImage(
                    profileUrl: item.itemImageUrl!,
                    width: double.infinity,
                    height: 300,
                    isProfile: false,
                  ),
                ),
              ],
            ),
            AppSpacing.smallSizedBox,
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.promoEndDate != null)
                    Text(
                      item.promoEndDate!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  AppSpacing.extraSmallSizedBox,
                  if (item.name != null)
                    Text(
                      item.name!,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  AppSpacing.extraSmallSizedBox,
                  PointsWidget(
                    points: item.requiredPoints,
                    pointTextStyle: Theme.of(context).textTheme.labelMedium,
                    promoPoints: item.promotionPoints,
                    promoPointTextStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Theme.of(context).hintColor),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  AppSpacing.smallSizedBox,
                  Text(
                    item.description ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
