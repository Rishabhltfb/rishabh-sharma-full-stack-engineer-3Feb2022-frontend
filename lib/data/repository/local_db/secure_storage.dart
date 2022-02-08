import 'package:client/data/api/local-storage/secure-storage.dart';

class SecureStorageRepository {
  static final SecureStorageRepository _instance =
      SecureStorageRepository._internal();
  final SecureStorage _secureStorage = SecureStorage();

  SecureStorageRepository._internal();

  factory SecureStorageRepository() {
    return _instance;
  }

  void addNewItem(String key, String value) {
    _secureStorage.addNewItem(key, value);
  }

  Future<String?> secureRead(String key) async {
    return await _secureStorage.secureRead(key);
  }

  Future<void> secureDelete(String key) {
    return _secureStorage.secureDelete(key);
  }

  Future<void> secureWrite(String key, String value) async {
    return _secureStorage.secureWrite(key, value);
  }
}
