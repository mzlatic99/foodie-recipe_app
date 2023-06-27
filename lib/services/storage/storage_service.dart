import '../../features/recipes/domain/recipe.dart';

/// Static class for defining keys for storing values
class StorageKeys {
  static const String currentLocale = 'current_locale';
}

/// Abstract class defining [StorageService] structure
/* abstract class StorageService {
  /// Delete value by key
  void deleteValue(String recipeId);

  /// Get all keys and values
  dynamic getAll();

  // Get lenght
  int getLength();

  bool hasValue(String id);

  /// Store new value
  Future<void> setValue({Recipe recipe});
} */
abstract class StorageService {
  /// Delete value by key
  Future<void> deleteValue(String key);

  /// Get value by key
  dynamic getValue(String key);

  /// Get all keys and values
  dynamic getAll();

  /// Check if key has value
  bool hasValue(String key);

  // Get lenght
  int getLength();

  Future<void> deleteAll();

  /// Store new value
  Future<void> setValue({String key, Recipe recipe});
}
