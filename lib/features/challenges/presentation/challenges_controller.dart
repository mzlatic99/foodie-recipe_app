import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/app_constants.dart';
import 'package:foodie/features/challenges/data/challenges_data.dart';

import '../../../providers/providers.dart';
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

  List<dynamic> get challenges => _challenges;
  int get challengesLength => _challenges.length;

  void replaceChallenge(Challenge challengeToBeReplaced, int index) {
    _challenges.removeAt(index);

    final storageServices = ref.watch(storageServiceProvider);

    for (Challenge challenge in _challenges) {
      storageServices.setValue(
          key: challenge.id.toString(),
          data: challenge,
          boxName: StorageBox.challangesBox);
    }

    state = storageServices.getAll(StorageBox.challangesBox);
  }

  void updateProgress(
      Challenge challenge, List<Challenge> displayedChallenges) {
    challenge.progress++;

    if (challenge.progress >= challenge.quantity) {
      challenge.completed = true;
    }

    if (challenge.completed) {
      replaceChallenge(challenge, 3);
    }
  }

  void saveChallenges() {
    ref.watch(storageServiceProvider).deleteAll(StorageBox.challangesBox);
    for (Challenge challenge in _challenges) {
      ref.watch(storageServiceProvider).setValue(
          key: challenge.id.toString(),
          data: challenge,
          boxName: StorageBox.challangesBox);
    }
  }

  /* void replaceChallenge(Challenge challengeToBeReplaced, int index) {
    final storageServices = ref.watch(storageServiceProvider);
    if (storageServices.getLength(StorageBox.challangesBox) > 3) {
      storageServices.deleteValue(
          challengeToBeReplaced.id.toString(), StorageBox.challangesBox);

      _challengesStorage
          .removeWhere((element) => element.id == challengeToBeReplaced.id);
      _challengesStorage.removeLast();
      final replacementChallenge =
          storageServices.getLastValue(StorageBox.challangesBox);
      storageServices.deleteLastValue(StorageBox.challangesBox);

      final newChallenge = Challenge(
        id: replacementChallenge.id,
        name: replacementChallenge.name,
        icon: replacementChallenge.icon,
        description: replacementChallenge.description,
        quantity: replacementChallenge.quantity,
        points: replacementChallenge.points,
        progress: replacementChallenge.progress,
      );
      storageServices.insertValue(
          index: index, data: newChallenge, boxName: StorageBox.challangesBox);
    }

    state = storageServices.getAll(StorageBox.challangesBox);
  } */

  DateTime currentWeekMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  DateTime currentWeekSunday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 7));
}
