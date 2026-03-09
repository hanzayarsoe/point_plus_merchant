import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String _accessKey = 'access_token';
  final String _refreshKey = 'refresh_token';
  final String _emailOrPhoneKey = 'email_phone';
  final String _passwordKey = 'password';
  final String _rememberMeKey = 'remember_me';
  final String _fcmKey = 'fcm_token';

  Future<String?> getAccessToken() async {
    return await _safeRead(_accessKey);
  }

  Future<String?> getRefreshToken() async {
    return await _safeRead(_refreshKey);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _safeWrite(_accessKey, accessToken);
    await _safeWrite(_refreshKey, refreshToken);
  }

  Future<void> deleteTokens() async {
    await _safeDelete(_accessKey);
    await _safeDelete(_refreshKey);
  }

  Future<void> deleteAccessToken() async {
    await _safeDelete(_accessKey);
  }

  Future<void> saveUserCredentials(String emailOrPhone, String password) async {
    await _safeWrite(_emailOrPhoneKey, emailOrPhone);
    await _safeWrite(_passwordKey, password);
  }

  Future<String?> getUserPhoneOrEmail() async {
    return await _safeRead(_emailOrPhoneKey);
  }

  Future<String?> getUserPasswrod() async {
    return await _safeRead(_passwordKey);
  }

  Future<void> deleteUserCredentials() async {
    await _safeDelete(_emailOrPhoneKey);
    await _safeDelete(_passwordKey);
    await _safeDelete(_rememberMeKey);
  }

  Future<void> saveFcmToken(String token) async {
    await _safeWrite(_fcmKey, token);
  }

  Future<String?> getFcmToken() async {
    return await _safeRead(_fcmKey);
  }

  Future<void> deleteFcmToken() async {
    await _safeDelete(_fcmKey);
  }

  Future<String?> _safeRead(String key) async {
    try {
      return await _storage.read(key: key);
    } on PlatformException catch (e) {
      if (_isDecryptError(e)) {
        await _storage.deleteAll();
        return null;
      }
      rethrow;
    }
  }

  Future<void> _safeWrite(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } on PlatformException catch (e) {
      if (_isDecryptError(e)) {
        await _storage.deleteAll();
        await _storage.write(key: key, value: value);
        return;
      }
      rethrow;
    }
  }

  Future<void> _safeDelete(String key) async {
    try {
      await _storage.delete(key: key);
    } on PlatformException catch (e) {
      if (_isDecryptError(e)) {
        await _storage.deleteAll();
        return;
      }
      rethrow;
    }
  }

  bool _isDecryptError(PlatformException e) {
    final message = '${e.message ?? ''} ${e.details ?? ''}'.toLowerCase();
    return message.contains('bad_decrypt') ||
        message.contains('badpaddingexception') ||
        message.contains('failed to unwrap key');
  }
}
