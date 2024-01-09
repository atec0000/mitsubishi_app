import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  Future<String> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token') ?? '';
  }

  Future<String> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token') ?? '';
  }

  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: 'access_token');
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: 'refresh_token');
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email') ?? '';
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  Future<String> getSavedPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_pwd') ?? '';
  }

  Future<void> savePassword(String pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_pwd', pwd);
  }

  Future<String> getSavedFamily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_family') ?? '';
  }

  Future<void> saveFamily(String family) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_family', family);
  }
}
