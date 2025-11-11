import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/store/presentation/widgets/store_detail_row.dart';

class StoreDetail extends StatelessWidget {
  final String? address;
  final String? primaryPhoneNumber;
  final String? secondaryPhoneNumber;
  final String? openTime;
  final String? closeTime;
  const StoreDetail({
    super.key,
    required this.address,
    required this.primaryPhoneNumber,
    required this.secondaryPhoneNumber,
    required this.openTime,
    required this.closeTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: Theme.of(context).textTheme.titleMedium),
        AppSpacing.smallSizedBox,
        StoreDetailRow(icon: LucideIcons.mapPinned, text: address ?? ''),
        AppSpacing.extraSmallSizedBox,
        StoreDetailRow(
          icon: LucideIcons.phone,
          text:
              '$primaryPhoneNumber${secondaryPhoneNumber != null ? ', ' : ''}$secondaryPhoneNumber',
        ),
        AppSpacing.extraSmallSizedBox,
        StoreDetailRow(
          icon: LucideIcons.clock3,
          text: '$openTime - $closeTime',
        ),
        AppSpacing.extraSmallSizedBox,
      ],
    );
  }
}
