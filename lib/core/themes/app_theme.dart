import 'package:flutter/material.dart';
import 'package:merchant/core/themes/bottom_naviagtion_bar_theme.dart';
import 'package:merchant/core/themes/elevated_button_theme.dart';
import 'package:merchant/core/themes/dark_theme.dart';
import 'package:merchant/core/themes/dialog_theme.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/themes/tab_bar_theme.dart';
import 'package:merchant/core/themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: DarkTheme.primaryColor,
      primaryContainer: DarkTheme.primaryContainerColor,
      onPrimaryContainer: DarkTheme.onPrimaryContainerColor,
      primaryFixed: DarkTheme.primaryFixed,
      surfaceBright: DarkTheme.surfaceBright,
      secondary: DarkTheme.secondaryColor,
      surface: DarkTheme.surfaceColor,
      onSurface: DarkTheme.onSurfaceColor,
      surfaceContainerHigh: DarkTheme.surfaceContainerHigh,
      surfaceContainerLow: DarkTheme.surfaceContainerLow,
      onSurfaceVariant: DarkTheme.onSurfaceVariant,
      error: DarkTheme.errorColor,
    ),
    textTheme: textTheme,

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    ),
    elevatedButtonTheme: darkElevatedButtonTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Walone',
      ),
      hintStyle: TextStyle(
        color: DarkTheme.hintColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Walone',
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkTheme.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkTheme.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: DarkTheme.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    bottomNavigationBarTheme: darkBottomNavigationBarTheme,
    tabBarTheme: darkTabBarThemeData,
    dialogTheme: darkDialogTheme,
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        gradientStart: DarkTheme.homeCardGradientStart,
        gradientEnd: DarkTheme.homeCardGradientEnd,
        buttonGradient: DarkTheme.elevatedButtonSecondaryColor,
        pointTransferCardBorderColor: DarkTheme.transferPointCardBorderColor,
        softBlueColor: DarkTheme.softBlueColor,
        actionBlueColor: DarkTheme.actionBlueColor,
        dimGrayColor: DarkTheme.dimGrayColor,
      ),
    ],
  );

  // static final ThemeData lightTheme = ThemeData(
  //   useMaterial3: true,
  //   brightness: Brightness.dark,
  //   colorScheme: ColorScheme.dark(
  //     primary: primaryColor,
  //     secondary: secondaryColor,
  //   ),
  //   elevatedButtonTheme: darkElevatedButtonTheme,
  // );
}
