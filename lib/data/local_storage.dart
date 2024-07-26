import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalStorage {
  Future<String?> read({required String key});

  Future<void> write({required String key, required String value});

  Future<void> delete({required String key});
}

class LocalStorageImplementation implements LocalStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future<void> delete({required String key}) async {
    await storage.delete(key: key);
  }

  @override
  Future<String?> read({required String key}) async {
    String? value = await storage.read(key: key);

    return value;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }
}
