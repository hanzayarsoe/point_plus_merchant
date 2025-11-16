import 'package:flutter/material.dart';
import 'package:merchant/core/utils/formatter.dart';

class TransferInfo extends StatelessWidget {
  final String type, accountNumber, name;
  const TransferInfo({
    super.key,
    required this.type,
    required this.accountNumber,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text.rich(
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        TextSpan(
          children: [
            TextSpan(
              text: '$type\n',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: '${Formatter.maskAndChunkString(accountNumber)}\n',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            TextSpan(text: name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
