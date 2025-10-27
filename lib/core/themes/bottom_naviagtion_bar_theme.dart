import 'package:flutter/material.dart';
import 'package:merchant/core/themes/dark_theme.dart';

final darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
  type: BottomNavigationBarType.fixed,
  backgroundColor: DarkTheme.surfaceContainerHigh,
  selectedItemColor: DarkTheme.primaryColor,
  selectedIconTheme: IconThemeData(color: DarkTheme.primaryColor),
  selectedLabelStyle: TextStyle(
    fontFamily: 'Walone',
    fontSize: 10,
    fontWeight: FontWeight.bold,
  ),
  unselectedItemColor: DarkTheme.onSurfaceColor,
  showUnselectedLabels: true,
  unselectedIconTheme: IconThemeData(color: DarkTheme.onSurfaceColor),
  unselectedLabelStyle: TextStyle(
    fontFamily: 'Walone',
    fontSize: 10,
    fontWeight: FontWeight.bold,
  ),
);
