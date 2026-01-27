import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';

class PointTransferCustomerInfoCard extends StatelessWidget {
  const PointTransferCustomerInfoCard({
    super.key,
    required this.isTypeRequest,
    required this.customerName,
    required this.phoneNumber,
    required this.customerProfile,
  });

  final bool isTypeRequest;
  final String customerName;
  final String phoneNumber;
  final String? customerProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.defaultPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(
          color: Theme.of(
            context,
          ).extension<AppColors>()!.pointTransferCardBorderColor!,
        ),
        borderRadius: AppSpacing.smallCircularBorderRadius,
      ),
      child: Column(
        children: [
          Row(
            spacing: AppSpacing.smallSpacing,
            children: [
              Text(
                isTypeRequest ? 'Transfer to' : 'Receive from',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Expanded(child: Divider()),
            ],
          ),
          AppSpacing.smallSizedBox,
          Row(
            spacing: AppSpacing.extraSmallSpacing,
            children: [
              ClipOval(
                child: CustomCachedNetworkImage(
                  profileUrl: customerProfile,
                  width: 60,
                  height: 60,
                  isProfile: true,
                ),
              ),
              AppSpacing.smallSizedBox,
              Text(
                "$customerName \n$phoneNumber",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
