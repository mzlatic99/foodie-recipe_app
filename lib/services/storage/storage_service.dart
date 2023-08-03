abstract class StorageService {
  late String user;

  Future<void> openBox<T>(String boxName);

  Future<void> closeBox<T>(String boxName);

  Future<void> deleteValue<T>(String key, String boxName);

  bool isBoxOpen(String boxName);

  dynamic getValue<T>(String key, String boxName);

  dynamic getAll<T>(String boxName);

  bool hasValue<T>(String key, String boxName);

  int getLength<T>(String boxName);

  void setValue<T>(String key, T data, String boxName);
}
