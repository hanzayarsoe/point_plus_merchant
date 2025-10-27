import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();
  static int defaultThemeMode = ThemeMode.dark.index;
  static const String defaultLanguageCode = 'en';
  static const int passwordLength = 6;
  static const int resendOtpWaitingTime = 60;
  static const int maxPhoneNumber = 11;
  static const int maxShownItem = 5;
  static const int qrCodeExpireTime = 30;
}
