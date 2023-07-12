import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constants.dart';
import '../../../providers/providers.dart';
import '../../../services/points/points.dart';
import '../../challenges/presentation/challenges_controller.dart';
import '../data/rewards_data.dart';
import '../domain/reward.dart';

final rewardsControllerProvider =
    StateNotifierProvider<RewardsController, List<dynamic>>((ref) {
  final rewards = ref.watch(rewardsDataProvider);
  return RewardsController(rewards, ref);
});

class RewardsController extends StateNotifier<List<dynamic>> {
  RewardsController(this._rewards, this.ref) : super(_rewards);
  final List<dynamic> _rewards;
  final Ref ref;

  List<dynamic> get rewards => _rewards;

  bool isRewardCompleted(int rewardId) {
    final storageService = ref.read(storageServiceProvider);
    final rewardInBox =
        storageService.getValue('$rewardId', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      final reward = _rewards.firstWhere((reward) => reward.id == rewardId);
      return reward.completed;
    } else {
      return rewardInBox.completed;
    }
  }

  void markRewardCompleted(int rewardId) async {
    final storageService = ref.read(storageServiceProvider);
    final rewardInBox =
        storageService.getValue('$rewardId', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      Reward reward = _rewards.firstWhere((reward) => reward.id == rewardId);
      reward.completed = true;
      await storageService.setValue('$rewardId', reward, StorageBox.rewardsBox);
    } else {
      rewardInBox.completed = true;
      await storageService.setValue(
          '$rewardId', rewardInBox, StorageBox.rewardsBox);
    }
  }

  int getTotalPoints() {
    final storageService = ref.read(storageServiceProvider);
    final totalPointsBox =
        storageService.getValue('totalPoints', StorageBox.pointsBox);
    final totalPoints = ref.read(pointsProvider);
    return totalPointsBox ?? totalPoints.getTotalPoints();
  }

  int getCurrentLevel() {
    final level = ref.read(pointsProvider).calculateLevel();
    return level;
  }

  int getCompletedChallengesCount() {
    final completedChallenges = ref
        .read(challengeControllerProvider.notifier)
        .numberOfCompletedChallenges;
    return completedChallenges;
  }

  int getSavedRecipesCount() {
    final storageService = ref.read(storageServiceProvider);
    final savedRecipesCount = storageService.getLength(StorageBox.favoritesBox);
    return savedRecipesCount;
  }

  void checkRewardConditions() {
    final totalPoints = getTotalPoints();
    final currentLevel = getCurrentLevel();
    final completedChallengesCount = getCompletedChallengesCount();
    final savedRecipesCount = getSavedRecipesCount();

    if (!isRewardCompleted(0) && totalPoints >= 10) {
      markRewardCompleted(0);
    }

    if (!isRewardCompleted(1) && completedChallengesCount >= 2) {
      markRewardCompleted(1);
    }

    if (!isRewardCompleted(2) && savedRecipesCount >= 2) {
      markRewardCompleted(2);
    }

    if (!isRewardCompleted(3) && currentLevel >= 2) {
      markRewardCompleted(3);
    }

    if (!isRewardCompleted(4) && currentLevel >= 3) {
      markRewardCompleted(4);
    }
  }
}
