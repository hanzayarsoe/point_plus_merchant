import 'package:flutter/material.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.title,
    required this.text,
    this.isTransfer,
    this.isWithdraw,
    this.isRecharge,
    this.isReceived,
  });

  final String title, text;
  final bool? isTransfer, isWithdraw, isRecharge, isReceived;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
        ),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
