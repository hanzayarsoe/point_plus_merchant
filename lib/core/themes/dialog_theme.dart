import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/dark_theme.dart';

final DialogThemeData darkDialogTheme = DialogThemeData(
  backgroundColor: DarkTheme.dialogBackgroundColor,
  insetPadding: AppSpacing.defaultPadding,
  shape: RoundedRectangleBorder(
    side: BorderSide(color: DarkTheme.dialogBorderColor),
    borderRadius: AppSpacing.normalBorderRadiusCircular,
  ),
);
