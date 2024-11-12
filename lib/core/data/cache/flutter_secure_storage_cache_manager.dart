import 'package:base_structure/core/domain/cache/icache_manager.dart';
import 'package:base_structure/core/enums/cache_key_enum.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageCacheManager implements ICacheManager {
  final storage = const FlutterSecureStorage();

  @override
  Future<String> getValueAsync(CacheKeyEnum key) async {
    var result = (await storage.read(key: key.name)) ?? "";
    return result;
  }

  @override
  Future<bool> setKeyAsync(CacheKeyEnum key, String value) async {
    await storage.write(key: key.name, value: value);

    return true;
  }

  ///Save a list of value into cache in one batch
  ///[keyValues] the list of key values to be saved
  @override
  Future<bool> setKeysAsync(Map<CacheKeyEnum, String> keyValues) async {
    for (var item in keyValues.entries) {
      await storage.write(key: item.key.name, value: item.value);
    }

    return true;
  }
}
