import 'package:hive_flutter/hive_flutter.dart';
import '../../constants/app_constants.dart';
import './storage_service.dart';

class HiveStorageService implements StorageService {
  HiveStorageService();
  @override
  String user = '';

  @override
  Future<void> openBox(String boxName) async {
    await Hive.openBox('$boxName$user');
  }

  @override
  Future<void> closeBox(String boxName) async {
    final box = Hive.box('$boxName$user');
    await box.close();
  }

  @override
  bool isBoxOpen(String boxName) {
    final isBoxOpen = Hive.isBoxOpen('$boxName$user');
    return isBoxOpen;
  }

  Future<void> clearBoxes() async {
    Hive.box(StorageBox.challengesBox).clear();
    Hive.box(StorageBox.favoritesBox).clear();
    Hive.box(StorageBox.pointsBox).clear();
    Hive.box(StorageBox.rewardsBox).clear();
  }

  @override
  Future<void> deleteValue(String key, String boxName) async {
    final box = Hive.box('$boxName$user');
    await box.delete(key);
  }

  @override
  int getLength(String boxName) {
    final box = Hive.box('$boxName$user');
    return box.length;
  }

  @override
  Future<void> insertValue(int? index, data, String boxName) {
    final box = Hive.box('$boxName$user');
    return box.putAt(index!, data);
  }

  @override
  dynamic getValue(String key, String boxName) {
    final box = Hive.box('$boxName$user');
    return box.get(key);
  }

  @override
  dynamic getAll(String boxName) {
    final box = Hive.box('$boxName$user');
    return box.values.toList();
  }

  @override
  bool hasValue(String key, String boxName) {
    final box = Hive.box('$boxName$user');
    return box.containsKey(key);
  }

  @override
  Future<void> deleteAll(String boxName) async {
    final box = Hive.box('$boxName$user');
    await box.clear();
  }

  @override
  Future<void> setValue(String? key, data, String boxName) async {
    final box = Hive.box('$boxName$user');
    await box.put(key, data);
  }

  @override
  Future<void> deleteLastValue(String boxName) async {
    final box = Hive.box('$boxName$user');
    final lastItemKey = box.keys.last;
    await box.delete(lastItemKey);
  }

  @override
  dynamic getLastValue(String boxName) {
    final box = Hive.box('$boxName$user');
    final lastItemKey = box.keys.last;
    return box.get(lastItemKey);
  }

  @override
  Future<void> removeWhere(
      String key, String boxName, bool Function(dynamic) condition) async {
    final box = Hive.box('$boxName$user');
    final item = box.get(key);
    if (item != null && condition(item)) {
      await box.delete(key);
    }
  }
}
