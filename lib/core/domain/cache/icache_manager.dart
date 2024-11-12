import 'package:base_structure/core/enums/cache_key_enum.dart';

abstract class ICacheManager {
  Future<String> getValueAsync(CacheKeyEnum key);
  Future<bool> setKeyAsync(CacheKeyEnum key, String value);
  Future<bool> setKeysAsync(Map<CacheKeyEnum, String> keyValues);
}
