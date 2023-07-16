import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/providers/providers.dart';

import '../../constants/app_constants.dart';
import '../../theme/theme_colors.dart';

final pointsProvider = Provider<Points>((ref) {
  return Points(ref);
});

class Points {
  Points(this.ref);
  final Ref ref;
  static const int recipePoints = 10;
  static const int challengePoints = 30;
  static const int pointsPerLevel = 20;

  int getTotalPoints() {
    final storageService = ref.read(storageServiceProvider);
    final totalPoints =
        storageService.getValue('totalPoints', StorageBox.pointsBox) ?? 0;
    return totalPoints as int;
  }

  Future<void> addPoints(int points) async {
    final storageService = ref.read(storageServiceProvider);
    final pointsStorage =
        storageService.getValue('totalPoints', StorageBox.pointsBox);
    if (pointsStorage != null) {
      int totalPointsBox = pointsStorage;
      totalPointsBox += points;
      await storageService.setValue(
          'totalPoints', totalPointsBox, StorageBox.pointsBox);
    } else {
      await storageService.setValue('totalPoints', 10, StorageBox.pointsBox);
    }
  }

  int calculateLevel() {
    final storageService = ref.read(storageServiceProvider);
    final int level;
    final pointsStorage =
        storageService.getValue('totalPoints', StorageBox.pointsBox);
    if (pointsStorage != null) {
      level = ((pointsStorage as int) ~/ pointsPerLevel) + 1;
    } else {
      level = 1;
    }
    return level;
  }
}
