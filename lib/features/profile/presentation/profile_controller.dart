import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/app_constants.dart';
import 'package:foodie/features/authentification/presentation/auth_controller.dart';
import 'package:foodie/features/challenges/data/challenges_data.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/features/recipes/data/http_recipe_repository.dart';
import 'package:foodie/features/recipes/presentation/recipe_controller.dart';

import '../../../providers/providers.dart';
import '../../../router/scaffold_with_bottom_nav_controller.dart';
import '../../../services/points/points.dart';
import '../../authentification/data/auth_repository.dart';
import '../../challenges/domain/challenge.dart';
import '../../recipes/domain/recipe.dart';
import '../../rewards/controller/rewards_controller.dart';
import '../../rewards/domain/reward.dart';

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, AsyncValue<void>>(
        (ref) {
  return ProfileController(ref);
});

class ProfileController extends StateNotifier<AsyncValue<void>> {
  ProfileController(this.ref) : super(const AsyncLoading());

  final Ref ref;

  Challenge completedChallengeBadgeToDisplay(int index) {
    final storageService = ref.watch(storageServiceProvider);
    List<Challenge> listOfChallengesToDisplay = [];
    final challengesInBox =
        storageService.getAll<Challenge>(StorageBox.challengesBox);
    for (Challenge challenge in challengesInBox) {
      if (challenge.completed) {
        listOfChallengesToDisplay.add(challenge);
      }
    }
    return listOfChallengesToDisplay[index];
  }

  Reward? rewardToDisplay(int index) {
    final rewardsController = ref.read(rewardsControllerProvider.notifier);
    final storageService = ref.watch(storageServiceProvider);
    final rewardInBox =
        storageService.getValue<Reward>('$index', StorageBox.rewardsBox);
    if (rewardInBox == null) {
      final reward = rewardsController.rewards[index];
      return reward;
    } else {
      final reward = rewardInBox as Reward;
      return reward;
    }
  }

  Future<void> signOut() async {
    final storageService = ref.watch(storageServiceProvider);
    final authRepository = ref.read(authRepositoryProvider);
    if (storageService.isBoxOpen(StorageBox.favoritesBox)) {
      await storageService.closeBox<Recipe>(StorageBox.favoritesBox);
    }
    if (storageService.isBoxOpen(StorageBox.challengesBox)) {
      await storageService.closeBox<Challenge>(StorageBox.challengesBox);
    }
    if (storageService.isBoxOpen(StorageBox.pointsBox)) {
      await storageService.closeBox<int>(StorageBox.pointsBox);
    }
    if (storageService.isBoxOpen(StorageBox.rewardsBox)) {
      await storageService.closeBox<Reward>(StorageBox.rewardsBox);
    }

    ref.watch(storageServiceProvider).user = '';
    await authRepository.signOut();

    ref.invalidate(scaffoldBottomNavControllerProvider);
    ref.invalidate(storageServiceProvider);
    ref.invalidate(pointsProvider);
    ref.invalidate(authRepositoryProvider);
    ref.invalidate(authControllerProvider);
    ref.invalidate(rewardsControllerProvider);
    ref.invalidate(challengeControllerProvider);
    ref.invalidate(challengesDataProvider);
    ref.invalidate(recipeControllerProvider);
    ref.invalidate(recipeRepositoryProvider);
  }
}
