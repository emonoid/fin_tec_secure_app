import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataHelper {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Locale
  Future<bool> setLocale(String? locale) async {
    if (locale == null) return false;
    await _storage.write(key: 'locale', value: locale);
    return true;
  }

  Future<String> getLocale() async {
    return await _storage.read(key: 'locale') ?? 'en';
  }

  // Theme
  Future<bool> setTheme(String theme) async {
    await _storage.write(key: 'theme', value: theme);
    return true;
  }

  Future<String> getTheme() async {
    return await _storage.read(key: 'theme') ?? 'light';
  }

  // Login flag
  Future<bool> setLoginFlag(bool flag) async {
    await _storage.write(key: 'isLoggedIn', value: flag.toString());
    return true;
  }

  Future<bool> getLoginFlag() async {
    final value = await _storage.read(key: 'isLoggedIn');
    return value == 'true';
  }

  // Subscription / accounts type
  Future<bool> setSubscriptionStatus(String accountsType) async {
    await _storage.write(key: 'accounts_type', value: accountsType);
    return true;
  }

  Future<String> getSubscriptionStatus() async {
    return await _storage.read(key: 'accounts_type') ?? '';
  }

  // Tokens
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

  // User ID
  Future<bool> setLoginUserId(int userId) async {
    await _storage.write(key: 'loginUserId', value: userId.toString());
    return true;
  }

  Future<int> getLoginUserId() async {
    final value = await _storage.read(key: 'loginUserId');
    return int.tryParse(value ?? '') ?? 0;
  }

  // Username
  Future<bool> setLoginUserName(String? username) async {
    await _storage.write(key: 'user_name', value: username ?? '');
    return true;
  }

  Future<String> getLoginUserName() async {
    return await _storage.read(key: 'user_name') ?? '';
  }

  // Mobile number
  Future<bool> setLoginUserMobileNo(String? mobileNo) async {
    await _storage.write(key: 'user_mobile_no', value: mobileNo ?? '');
    return true;
  }

  Future<String> getLoginUserMobileNo() async {
    return await _storage.read(key: 'user_mobile_no') ?? '';
  }

  // Address
  Future<bool> setUserAddress(String address) async {
    await _storage.write(key: 'address', value: address);
    return true;
  }

  Future<String> getUserAddress() async {
    return await _storage.read(key: 'address') ?? '';
  }

  // Shop ID
  Future<bool> setShopId(int shopId) async {
    await _storage.write(key: 'shop_id', value: shopId.toString());
    return true;
  }

  Future<int?> getShopId() async {
    final value = await _storage.read(key: 'shop_id');
    return int.tryParse(value ?? '');
  }

  // User ID
  Future<bool> setUserId(int userId) async {
    await _storage.write(key: 'userId', value: userId.toString());
    return true;
  }

  Future<int?> getUserId() async {
    final value = await _storage.read(key: 'userId');
    return int.tryParse(value ?? '');
  }

  // Role
  Future<bool> setRole(String role) async {
    await _storage.write(key: 'role', value: role);
    return true;
  }

  Future<String> getRole() async {
    return await _storage.read(key: 'role') ?? 'emp';
  }
}
