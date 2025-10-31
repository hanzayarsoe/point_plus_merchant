import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? gradientStart;
  final Color? gradientEnd;
  final Color? buttonGradient;
  final Color? pointTransferCardBorderColor;
  final Color? pointTransferBalanceColor;

  const AppColors({
    required this.gradientStart,
    required this.gradientEnd,
    required this.buttonGradient,
    required this.pointTransferCardBorderColor,
    required this.pointTransferBalanceColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? buttonGradient,
    Color? pointTransferCardBorderColor,
    Color? pointTransferBalanceColor,
  }) {
    return AppColors(
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      pointTransferCardBorderColor:
          pointTransferCardBorderColor ?? this.pointTransferCardBorderColor,
      pointTransferBalanceColor:
          pointTransferBalanceColor ?? this.pointTransferBalanceColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t),
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t),
      buttonGradient: Color.lerp(buttonGradient, other.buttonGradient, t),
      pointTransferCardBorderColor: Color.lerp(
        pointTransferCardBorderColor,
        other.pointTransferCardBorderColor,
        t,
      ),
      pointTransferBalanceColor: Color.lerp(
        pointTransferBalanceColor,
        other.pointTransferBalanceColor,
        t,
      ),
    );
  }
}
