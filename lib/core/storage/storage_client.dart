abstract class StorageClient {
  Future<T?> read<T>(String key);
  Future write<T>(String key, T value);
  Future delete(String key);
  Future deleteAll({List<String> ignoredKeys = const []});
}



