import 'package:flutter/material.dart';
import 'package:merchant/core/themes/dark_theme.dart';
import 'package:merchant/core/themes/text_theme.dart';

final TabBarThemeData darkTabBarThemeData = TabBarThemeData(
  tabAlignment: TabAlignment.center,
  labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
  dividerHeight: 0.1,
  dividerColor: DarkTheme.surfaceContainerHigh,
  indicatorSize: TabBarIndicatorSize.tab,
  unselectedLabelStyle: textTheme.titleSmall!.copyWith(
    fontWeight: FontWeight.normal,
    color: DarkTheme.onSurfaceColor,
  ),
  labelStyle: textTheme.titleSmall!.copyWith(color: DarkTheme.primaryColor),
);
