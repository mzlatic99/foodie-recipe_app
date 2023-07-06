import 'package:hive_flutter/hive_flutter.dart';
import './storage_service.dart';

/// Implementation of [StorageService] with [Hive]
class HiveStorageService implements StorageService {
  HiveStorageService();

  Future<void> openBox(String boxName) async {
    await Hive.openBox(boxName);
  }

  Future<void> closeBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.close();
  }

  @override
  Future<void> deleteValue(String key, String boxName) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  @override
  int getLength(String boxName) {
    final box = Hive.box(boxName);
    return box.length;
  }

  @override
  Future<void> insertValue({int? index, data, String? boxName}) {
    final box = Hive.box(boxName!);
    return box.putAt(index!, data);
  }

  @override
  dynamic getValue(String key, String boxName) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  @override
  dynamic getAll(String boxName) {
    final box = Hive.box(boxName);
    return box.values.toList();
  }

  @override
  bool hasValue(String key, String boxName) {
    final box = Hive.box(boxName);
    return box.containsKey(key);
  }

  @override
  Future<void> deleteAll(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  @override
  Future<void> setValue({String? key, data, String? boxName}) async {
    final box = Hive.box(boxName!);
    await box.put(key, data);
  }

  @override
  Future<void> deleteLastValue(String boxName) async {
    final box = Hive.box(boxName);
    final lastItemKey = box.keys.last;
    await box.delete(lastItemKey);
  }

  @override
  dynamic getLastValue(String boxName) {
    final box = Hive.box(boxName);
    final lastItemKey = box.keys.last;
    return box.get(lastItemKey);
  }

  @override
  Future<void> removeWhere(
      String key, String boxName, bool Function(dynamic) condition) async {
    final box = Hive.box(boxName);
    final item = box.get(key);
    if (item != null && condition(item)) {
      await box.delete(key);
    }
  }
}
