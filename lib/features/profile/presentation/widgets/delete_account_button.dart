import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.mediumSpacing),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: AppSpacing.bigBorderRadiusCircular,
        ),
        child: Text(
          'Delete Account',
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
