import 'package:hive_flutter/hive_flutter.dart';
import 'storage_service.dart';

class HiveStorageService implements StorageService {
  HiveStorageService();

  @override
  String user = '';

  @override
  Future<void> openBox<T>(String boxName) async {
    await Hive.openBox<T>('$boxName$user');
  }

  @override
  Future<void> closeBox<T>(String boxName) async {
    final box = Hive.box<T>('$boxName$user');
    await box.close();
  }

  Future<void> closeCurrentUserBox() async {
    if (user.isNotEmpty) {
      await Hive.close();
    }
  }

  @override
  bool isBoxOpen(String boxName) {
    final isBoxOpen = Hive.isBoxOpen('$boxName$user');
    return isBoxOpen;
  }

  @override
  Future<void> deleteValue<T>(String key, String boxName) async {
    final box = Hive.box<T>('$boxName$user');
    await box.delete(key);
  }

  @override
  int getLength<T>(String boxName) {
    final box = Hive.box<T>('$boxName$user');
    return box.length;
  }

  @override
  dynamic getValue<T>(String key, String boxName) {
    final box = Hive.box<T>('$boxName$user');
    return box.get(key, defaultValue: null);
  }

  @override
  dynamic getAll<T>(String boxName) {
    final box = Hive.box<T>('$boxName$user');
    return box.values.toList();
  }

  @override
  bool hasValue<T>(String key, String boxName) {
    final box = Hive.box<T>('$boxName$user');
    return box.containsKey(key);
  }

  @override
  void setValue<T>(String? key, T data, String boxName) async {
    final box = Hive.box<T>('$boxName$user');
    await box.put(key, data);
  }
}
