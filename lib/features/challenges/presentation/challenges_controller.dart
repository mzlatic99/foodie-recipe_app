import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/storage_box_constants.dart';
import 'package:foodie/features/challenges/data/challenges_data.dart';

import '../../../providers/providers.dart';
import '../../../services/points/points.dart';
import '../../recipes/domain/recipe.dart';
import '../../recipes/domain/recipe_ingredients/component.dart';
import '../domain/challenge.dart';

final challengeControllerProvider =
    StateNotifierProvider<ChallengesController, List<dynamic>>((ref) {
  final challenges = ref.watch(challengesDataProvider);

  return ChallengesController(ref, challenges);
});

class ChallengesController extends StateNotifier<List<dynamic>> {
  final List<dynamic> _challenges;

  ChallengesController(this.ref, this._challenges) : super(_challenges);

  final Ref ref;

  int get numberOfChallengesDisplayed => 3;
  double get rowHeight => 70;

  List<dynamic> get challenges => _challenges;

  void replaceChallenge(Challenge challengeToBeReplaced) {
    final storageService = ref.watch(storageServiceProvider);
    _challenges
        .removeWhere((element) => element.id == challengeToBeReplaced.id);
    final isChallengeInBox = storageService.hasValue<Challenge>(
        challengeToBeReplaced.id.toString(), StorageBox.challengesBox);
    if (isChallengeInBox) {
      storageService.deleteValue<Challenge>(
          challengeToBeReplaced.id.toString(), StorageBox.challengesBox);
    }
    for (Challenge challenge in _challenges) {
      if (!storageService.hasValue<Recipe>(
          challenge.id.toString(), StorageBox.favoritesBox)) {
        ref.watch(storageServiceProvider).setValue<Challenge>(
            challenge.id.toString(), challenge, StorageBox.challengesBox);
      }
    }
    state = storageService.getAll<Challenge>(StorageBox.challengesBox);
  }

  void updateProgress(int challengeId) {
    final storageService = ref.watch(storageServiceProvider);
    final challengeInBox = storageService.getValue<Challenge>(
        challengeId.toString(), StorageBox.challengesBox);
    if (challengeInBox != null && !challengeInBox.completed) {
      final points = ref.watch(pointsProvider);
      challengeInBox.progress++;
      if (challengeInBox.progress == challengeInBox.quantity) {
        challengeInBox.completed = true;
        points.addPoints(challengeInBox.points);
      }
      storageService.setValue<Challenge>(challengeInBox.id.toString(),
          challengeInBox, StorageBox.challengesBox);
    } else if (challengeInBox == null) {
      final points = ref.watch(pointsProvider);
      final storageService = ref.watch(storageServiceProvider);
      final challengesInBox =
          storageService.getAll<Challenge>(StorageBox.challengesBox);
      if (challengesInBox.isEmpty) {
        final challengeToUpdate =
            _challenges.firstWhere((element) => element.id == challengeId);
        for (Challenge challenge in _challenges) {
          if (challenge == challengeToUpdate) {
            challenge.progress++;
            if (challenge.progress == challenge.quantity) {
              challenge.completed = true;
              points.addPoints(challenge.points);
            }
          }
          storageService.setValue<Challenge>(
              challenge.id.toString(), challenge, StorageBox.challengesBox);
        }
      }
    }
  }

  void checkChallengesConditions(Recipe recipe) {
    final components = recipe.sections[0].components;
    for (Component component in components) {
      final ingredient = component.ingredient.name;
      if (ingredient.toLowerCase().contains('egg')) {
        updateProgress(0);
      }
      if (ingredient.toLowerCase().contains('tomato') ||
          ingredient.toLowerCase().contains('salad')) {
        updateProgress(1);
      }
      if (ingredient.toLowerCase().contains('chicken')) {
        updateProgress(2);
      }
      if (ingredient.toLowerCase().contains('vanilla') ||
          ingredient.toLowerCase().contains('chocolate')) {
        updateProgress(3);
      }
    }
  }

  int getNumberOfCompletedChallenges() {
    final storageService = ref.watch(storageServiceProvider);
    int completedCount = 0;
    final challengesInBox =
        storageService.getAll<Challenge>(StorageBox.challengesBox);
    for (Challenge challenge in challengesInBox) {
      if (challenge.completed) {
        completedCount++;
      }
    }
    return completedCount;
  }

  Challenge challengeToDisplay(int index) {
    final storageService = ref.watch(storageServiceProvider);
    final challengesInBox =
        storageService.getAll<Challenge>(StorageBox.challengesBox);
    return challengesInBox.isNotEmpty
        ? challengesInBox[index]
        : _challenges[index];
  }

  DateTime currentWeekMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  DateTime currentWeekSunday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 7));
}
