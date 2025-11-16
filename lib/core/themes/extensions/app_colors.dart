import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? gradientStart;
  final Color? gradientEnd;
  final Color? buttonGradient;
  final Color? pointTransferCardBorderColor;
  final Color? softBlueColor;
  final Color? actionBlueColor;
  final Color? dimGrayColor;

  const AppColors({
    required this.gradientStart,
    required this.gradientEnd,
    required this.buttonGradient,
    required this.pointTransferCardBorderColor,
    required this.softBlueColor,
    required this.actionBlueColor,
    required this.dimGrayColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? buttonGradient,
    Color? pointTransferCardBorderColor,
    Color? softBlueColor,
    Color? actionBlueColor,
    Color? dimGrayColor,
  }) {
    return AppColors(
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      pointTransferCardBorderColor:
          pointTransferCardBorderColor ?? this.pointTransferCardBorderColor,
      softBlueColor: softBlueColor ?? this.softBlueColor,
      actionBlueColor: actionBlueColor ?? this.actionBlueColor,
      dimGrayColor: dimGrayColor ?? this.dimGrayColor,
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
      softBlueColor: Color.lerp(softBlueColor, other.softBlueColor, t),
      actionBlueColor: Color.lerp(actionBlueColor, other.actionBlueColor, t),
      dimGrayColor: Color.lerp(dimGrayColor, other.dimGrayColor, t),
    );
  }
}
