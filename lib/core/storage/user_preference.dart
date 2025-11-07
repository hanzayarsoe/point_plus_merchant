import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  final String _themeKey = 'theme_mode';
  final String _languageKey = 'language_code';
  final String _rememberKey = 'remember_me';
  final String _notiKey = 'push_notification';
  // final FirebaseMessaging _fcm;
  final SharedPreferences _pref;
  UserPreference(this._pref);

  ThemeMode getThemeMode() {
    final themeIndex = _pref.getInt(_themeKey) ?? AppConstants.defaultThemeMode;
    return ThemeMode.values[themeIndex];
  }

  Future<bool> setThemeMode(ThemeMode themeMode) async {
    return await _pref.setInt(_themeKey, themeMode.index);
  }

  String getLanguageCode() {
    return _pref.getString(_languageKey) ?? AppConstants.defaultLanguageCode;
  }

  Future<bool> setLanguageCode(String langaugeCode) async {
    return await _pref.setString(_languageKey, langaugeCode);
  }

  bool getRememberMe() {
    return _pref.getBool(_rememberKey) ?? false;
  }

  Future<bool> setRememberMe(bool rememberMe) async {
    return await _pref.setBool(_rememberKey, rememberMe);
  }

  Future<bool> areNotiEnabled() async {
    return _pref.getBool(_notiKey) ?? true;
  }

  Future<void> setNotiEnabled(bool isEnabled) async {
    await _pref.setBool(_notiKey, isEnabled);

    // if (isEnabled) {
    //   await _fcm.subscribeToTopic('all_users');
    // } else {
    //   await _fcm.unsubscribeFromTopic('all_users');
    // }
  }
}
