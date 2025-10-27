import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    required this.onPressed,
    this.borderRadius,
    required this.text,
    required this.isDisabled,
  });

  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: isDisabled
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(25.0),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    ?Theme.of(context).extension<AppColors>()!.buttonGradient,
                  ],
                ),
                borderRadius: BorderRadius.circular(35.0),
              ),
        child: Container(
          height: 48,
          padding: AppSpacing.gradientButtonPadding,
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
        ),
      ),
    );
  }
}
