abstract class StorageService {
  /// Delete value by key
  Future<void> deleteValue(String key, String boxName);

  Future<void> deleteLastValue(String boxName);

  /// Get value by key
  dynamic getValue(String key, String boxName);

  dynamic getLastValue(String boxName);

  /// Get all keys and values
  dynamic getAll(String boxName);

  /// Check if key has value
  bool hasValue(String key, String boxName);

  // Get lenght
  int getLength(String boxName);

  Future<void> deleteAll(String boxName);

  Future<void> insertValue({int index, data, String boxName});

  /// Store new value
  Future<void> setValue({String key, data, String boxName});

  Future<void> removeWhere(
      String key, String boxName, bool Function(dynamic) condition);
}
