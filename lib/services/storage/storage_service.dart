abstract class StorageService {
  late String user;

  Future<void> openBox(String boxName);

  Future<void> closeBox(String boxName);

  Future<void> deleteValue(String key, String boxName);

  Future<void> deleteLastValue(String boxName);

  bool isBoxOpen(String boxName);

  dynamic getValue(String key, String boxName);

  dynamic getLastValue(String boxName);

  dynamic getAll(String boxName);

  bool hasValue(String key, String boxName);

  int getLength(String boxName);

  Future<void> deleteAll(String boxName);

  Future<void> insertValue(int index, data, String boxName);

  Future<void> setValue(String key, data, String boxName);

  Future<void> removeWhere(
      String key, String boxName, bool Function(dynamic) condition);
}
