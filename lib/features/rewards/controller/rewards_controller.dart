import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constants.dart';
import '../../../providers/providers.dart';
import '../../../services/points/points.dart';
import '../../challenges/presentation/challenges_controller.dart';
import '../../recipes/domain/recipe.dart';
import '../data/rewards_data.dart';
import '../domain/reward.dart';

final rewardsControllerProvider =
    StateNotifierProvider.autoDispose<RewardsController, AsyncValue<void>>(
        (ref) {
  final rewards = ref.watch(rewardsDataProvider);
  return RewardsController(rewards, ref);
});

class RewardsController extends StateNotifier<AsyncValue<void>> {
  RewardsController(this._rewards, this.ref) : super(const AsyncLoading());
  final List<dynamic> _rewards;
  final Ref ref;

  List<dynamic> get rewards => _rewards;

  bool isRewardCompleted(int rewardId) {
    final storageService = ref.watch(storageServiceProvider);
    final rewardInBox =
        storageService.getValue<Reward>('$rewardId', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      final reward = _rewards.firstWhere((reward) => reward.id == rewardId);
      return reward.completed;
    } else {
      return rewardInBox.completed;
    }
  }

  void markRewardCompleted(int rewardId) {
    final storageService = ref.watch(storageServiceProvider);
    final rewardInBox =
        storageService.getValue<Reward>('$rewardId', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      Reward reward = _rewards.firstWhere((reward) => reward.id == rewardId);
      reward.completed = true;
      storageService.setValue<Reward>(
          '$rewardId', reward, StorageBox.rewardsBox);
    } else {
      rewardInBox.completed = true;
      storageService.setValue<Reward>(
          '$rewardId', rewardInBox, StorageBox.rewardsBox);
    }
  }

  int getTotalPoints() {
    final storageService = ref.watch(storageServiceProvider);
    final totalPointsBox =
        storageService.getValue<int>('totalPoints', StorageBox.pointsBox);
    final totalPoints = ref.watch(pointsProvider);
    return totalPointsBox ?? totalPoints.getTotalPoints();
  }

  int getCurrentLevel() {
    final level = ref.watch(pointsProvider).calculateLevel();
    return level;
  }

  int getCompletedChallengesCount() {
    final completedChallenges = ref
        .read(challengeControllerProvider.notifier)
        .getNumberOfCompletedChallenges();
    return completedChallenges;
  }

  int getSavedRecipesCount() {
    final storageService = ref.read(storageServiceProvider);
    final savedRecipesCount =
        storageService.getLength<Recipe>(StorageBox.favoritesBox);
    return savedRecipesCount;
  }

  void checkRewardConditions() {
    final totalPoints = getTotalPoints();
    final currentLevel = getCurrentLevel();
    final completedChallengesCount = getCompletedChallengesCount();
    final savedRecipesCount = getSavedRecipesCount();

    if (isRewardCompleted(0) == false && totalPoints >= 10) {
      markRewardCompleted(0);
    }

    if (isRewardCompleted(1) == false && completedChallengesCount >= 3) {
      markRewardCompleted(1);
    }

    if (isRewardCompleted(2) == false && savedRecipesCount >= 2) {
      markRewardCompleted(2);
    }

    if (isRewardCompleted(3) == false && currentLevel >= 2) {
      markRewardCompleted(3);
    }

    if (isRewardCompleted(4) == false && currentLevel >= 3) {
      markRewardCompleted(4);
    }
  }
}
