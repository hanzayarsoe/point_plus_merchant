import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';

class StoreHeader extends StatelessWidget {
  final String? storeName;
  final double? rating;
  final String? profileUrl;
  const StoreHeader({
    super.key,
    required this.storeName,
    required this.profileUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: AppSpacing.normalBorderRadiusCircular,
          child: CustomCachedNetworkImage(
            profileUrl: profileUrl,
            width: 100,
            height: 100,
            isProfile: false,
          ),
        ),
        SizedBox(width: AppSpacing.extraLargeSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.extraSmallSizedBox,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.smallSpacing,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).extension<AppColors>()!.softBlueColor,
                  borderRadius: AppSpacing.normalBorderRadiusCircular,
                ),
                child: Text(
                  'store',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppSpacing.extraSmallSizedBox,
              Row(
                children: [
                  RatingBar(
                    allowHalfRating: true,
                    direction: Axis.horizontal,
                    itemSize: 18,
                    minRating: 3,
                    maxRating: 5,
                    initialRating: 4,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      half: Icon(
                        Icons.star_half,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      empty: Icon(Icons.star_outline),
                    ),
                    onRatingUpdate: (_) => (),
                  ),
                  SizedBox(width: AppSpacing.smallSpacing),
                  Text(
                    '(10 reviews)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
