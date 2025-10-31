import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class AccountActionPromt extends StatelessWidget {
  final String title;
  final String textButton;
  final VoidCallback onPressed;
  final MainAxisAlignment? mainAxisAlignment;
  final bool? isButtonDisabled;
  const AccountActionPromt({
    super.key,
    required this.title,
    required this.textButton,
    required this.onPressed,
    this.mainAxisAlignment,
    this.isButtonDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(width: AppSpacing.extraSmallSpacing),
        TextButton(
          style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
          onPressed: isButtonDisabled != null && isButtonDisabled!
              ? () {}
              : onPressed,
          child: Text(
            textButton,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: isButtonDisabled != null && isButtonDisabled!
                  ? Theme.of(context).colorScheme.primary.withAlpha(100)
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
