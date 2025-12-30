import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';

class TransactionRow extends StatelessWidget {
  final String title, date, amount;
  final String? party, status;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  const TransactionRow({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.party,
    this.status,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTransfer = title.toLowerCase().contains('transfer');
    final isReceived = title.toLowerCase().contains('received');
    final isRecharge = title.toLowerCase().contains('recharge');
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.historyTransactionPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            left: BorderSide(color: Theme.of(context).colorScheme.secondary),
            right: BorderSide(color: Theme.of(context).colorScheme.secondary),
            bottom: BorderSide(
              color: Theme.of(context).extension<AppColors>()!.dimGrayColor!,
            ),
          ),
        ),
        child: Row(
          children: [
            CustomIcon(
              icon: Icon(
                isTransfer
                    ? LucideIcons.arrowUpRight
                    : isReceived
                    ? LucideIcons.arrowDownRight
                    : LucideIcons.sparkle,
                size: 20,
                weight: 700,
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: AppSpacing.smallPadding,
              paddingColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            SizedBox(width: AppSpacing.smallSpacing),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.smallSizedBox,
                  Text(
                    Formatter.formatUtcTimeToHistoryTransactionDateTime(date),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(
                        context,
                      ).extension<AppColors>()!.dimGrayColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (isReceived || isRecharge
                          ? '+ ${Formatter.formatNumber(int.parse(amount))} pts'
                          : '- ${Formatter.formatNumber(int.parse(amount))} pts'),
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                    AppSpacing.smallSizedBox,
                    if (party != null)
                      Text(
                        party!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(
                            context,
                          ).extension<AppColors>()!.dimGrayColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    if (status != null)
                      Text(
                        status!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
