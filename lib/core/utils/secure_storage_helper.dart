import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _storage;

  SecureStorageHelper(this._storage);

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  Future<String?> read(String key) async {
    return await _storage.read(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<void> write(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<bool?> readBool(String key) async {
    final value = await read(key);
    if (value == null) return null;
    return value == 'true';
  }

  Future<void> writeBool(String key, bool value) async {
    await write(key, value.toString());
  }

  Future<void> delete(String key) async {
    await _storage.delete(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<void> clearAll() async {
    await _storage.deleteAll(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }
}
