import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/app_constants.dart';

import '../../../../services/storage/hive_storage_service.dart';
import '../../../providers/providers.dart';
import '../../../services/points/points.dart';
import '../../authentification/data/auth_repository.dart';
import '../../challenges/domain/challenge.dart';
import '../../challenges/presentation/challenges_controller.dart';
import '../../rewards/controller/rewards_controller.dart';
import '../../rewards/domain/reward.dart';

final profileControllerProvider = Provider<ProfileController>((ref) {
  return ProfileController(ref);
});

class ProfileController {
  ProfileController(this.ref);

  final Ref ref;

  String displayPoints() {
    String totalPoints = ref.watch(pointsProvider).getTotalPoints().toString();
    return totalPoints;
  }

  String displayLevel() {
    final points = ref.watch(pointsProvider);
    String level = points.calculateLevel().toString();
    return level;
  }

  Challenge challengeToDisplay(int index) {
    final challengeController = ref.watch(challengeControllerProvider.notifier);
    final storageService = ref.watch(storageServiceProvider);
    final challenge = storageService.getLength(StorageBox.challengesBox) > 0
        ? storageService.getAll(StorageBox.challengesBox)[index] as Challenge
        : challengeController.challenges[index] as Challenge;
    return challenge;
  }

  Reward rewardToDisplay(int index) {
    final rewardsController = ref.read(rewardsControllerProvider.notifier);
    final storageService = ref.watch(storageServiceProvider);
    final rewardInBox =
        storageService.getValue('$index', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      final reward = rewardsController.rewards[index];
      return reward;
    } else {
      final reward = rewardInBox;
      return reward;
    }
  }

  Future<void> signOut() async {
    final storageService = HiveStorageService();
    if (storageService.isBoxOpen(StorageBox.favoritesBox)) {
      storageService.closeBox(StorageBox.favoritesBox);
    }
    if (storageService.isBoxOpen(StorageBox.pointsBox)) {
      storageService.closeBox(StorageBox.pointsBox);
    }
    if (storageService.isBoxOpen(StorageBox.challengesBox)) {
      storageService.closeBox(StorageBox.challengesBox);
    }
    if (storageService.isBoxOpen(StorageBox.rewardsBox)) {
      storageService.closeBox(StorageBox.rewardsBox);
    }
    storageService.user = '';
    await ref.read(authRepositoryProvider).signOut();
  }
}
