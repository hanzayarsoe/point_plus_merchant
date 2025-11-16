import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/history/presentation/widgets/points_flow_text.dart';

class TransactionHeader extends StatelessWidget {
  final String groupTitle, inflow, outflow;
  const TransactionHeader({
    super.key,
    required this.groupTitle,
    required this.inflow,
    required this.outflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.historyTransactionPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.smallSpacing),
        ),
      ),
      child: Column(
        children: [
          Text(groupTitle, style: Theme.of(context).textTheme.headlineLarge),
          AppSpacing.smallSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PointsFlowText(title: 'Inflow', amount: inflow),
              PointsFlowText(
                title: 'Outflow',
                amount: outflow,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
