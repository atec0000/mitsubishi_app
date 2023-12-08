import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
