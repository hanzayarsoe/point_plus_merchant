import 'package:flutter/material.dart';

class PointsFlowText extends StatelessWidget {
  final String title, amount;
  final TextAlign? textAlign;
  const PointsFlowText({
    super.key,
    required this.title,
    required this.amount,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: textAlign,
      TextSpan(
        children: [
          TextSpan(text: '$title\n'),
          TextSpan(
            text: '$amount pts',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
