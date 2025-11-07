import 'package:flutter/material.dart';
import 'package:merchant/core/themes/dark_theme.dart';

final ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    surfaceTintColor: DarkTheme.elevatedButtonSecondaryColor,
    elevation: 0,
    padding: EdgeInsets.symmetric(vertical: 4),
    foregroundColor: DarkTheme.blackColor,
    backgroundColor: DarkTheme.primaryColor,
    disabledForegroundColor: DarkTheme.disabledForegroundColor,
    disabledBackgroundColor: DarkTheme.disabledBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    minimumSize: Size(double.infinity, 48),
    textStyle: TextStyle(
      fontFamily: 'Walone',
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
