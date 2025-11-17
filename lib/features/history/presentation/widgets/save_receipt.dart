import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class SaveReceiptButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SaveReceiptButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: AppSpacing.smallCircularBorderRadius,
        ),
        child: Center(
          child: Text(
            'Save Receipt',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
