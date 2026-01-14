import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalDataHelper {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> setLocale(String? locale) async {
    if (locale == null) return false;
    await _storage.write(key: 'locale', value: locale);
    return true;
  }

  Future<String> getLocale() async {
    return await _storage.read(key: 'locale') ?? 'en';
  }

  Future<bool> setTheme(String theme) async {
    await _storage.write(key: 'theme', value: theme);
    return true;
  }

  Future<String> getTheme() async {
    return await _storage.read(key: 'theme') ?? 'light';
  }

  Future<bool> setLoginFlag(bool flag) async {
    await _storage.write(key: 'isLoggedIn', value: flag.toString());
    return true;
  }

  Future<bool> getLoginFlag() async {
    final value = await _storage.read(key: 'isLoggedIn');
    return value == 'true';
  }

  Future<bool> setToken(String? token) async {
    if (token == null) return false;
    await _storage.write(key: 'accesstoken', value: token);
    return true;
  }

  Future<String> getToken() async {
    return await _storage.read(key: 'accesstoken') ?? '';
  }

  Future<bool> setRefreshToken(String? token) async {
    if (token == null) return false;
    await _storage.write(key: 'refreshtoken', value: token);
    return true;
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: 'refreshtoken') ?? '';
  }

  Future<bool> setBiometricFlag(bool flag) async {
    await _storage.write(key: 'isBiometricEnabled', value: flag.toString());
    return true;
  }

  Future<bool> getBiometricFlag() async {
    final value = await _storage.read(key: 'isBiometricEnabled');
    return value == 'true';
  }
}
