import 'package:flutter/material.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.title,
    required this.text,

    this.isTransfer,
    this.isWithdraw,
    this.isRecharge,
    this.isReceived,
    this.textStyle,
    this.titleTextStyle,
  });

  final String title, text;
  final bool? isTransfer, isWithdraw, isRecharge, isReceived;
  final TextStyle? textStyle;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              titleTextStyle ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).extension<AppColors>()!.lightGray,
              ),
        ),
        Text(text, style: textStyle ?? Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
