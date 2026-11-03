import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String _key = 'auth_token';

  final FlutterSecureStorage _storage;
  String? _memoryToken;

  TokenStorage(this._storage);

  Future<String?> read() async {
    _memoryToken ??= await _storage.read(key: _key);
    return _memoryToken;
  }

  Future<void> save(String token, {required bool persist}) async {
    _memoryToken = token;
    if (persist) {
      await _storage.write(key: _key, value: token);
    } else {
      await _storage.delete(key: _key);
    }
  }

  Future<void> clear() async {
    _memoryToken = null;
    await _storage.delete(key: _key);
  }
}
