import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String _accessKey = 'access_token';
  final String _refreshKey = 'refresh_token';
  final String _emailOrPhoneKey = 'email_phone';
  final String _passwordKey = 'password';
  final String _rememberMeKey = 'remember_me';
  final String _fcmKey = 'fcm_token';

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshKey);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessKey);
  }

  Future<void> saveUserCredentials(String emailOrPhone, String password) async {
    await _storage.write(key: _emailOrPhoneKey, value: emailOrPhone);
    await _storage.write(key: _passwordKey, value: password);
  }

  Future<String?> getUserPhoneOrEmail() async {
    return await _storage.read(key: _emailOrPhoneKey);
  }

  Future<String?> getUserPasswrod() async {
    return await _storage.read(key: _passwordKey);
  }

  Future<void> deleteUserCredentials() async {
    await _storage.delete(key: _emailOrPhoneKey);
    await _storage.delete(key: _passwordKey);
    await _storage.delete(key: _rememberMeKey);
  }

  Future<String?> getFcmToken() async {
    return await _storage.read(key: _fcmKey);
  }

  Future<void> deleteFcmToken() async {
    await _storage.delete(key: _fcmKey);
  }
}
