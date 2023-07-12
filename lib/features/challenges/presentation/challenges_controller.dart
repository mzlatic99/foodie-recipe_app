import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/app_constants.dart';
import 'package:foodie/features/challenges/data/challenges_data.dart';

import '../../../providers/providers.dart';
import '../../../services/points/points.dart';
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

  int get numberOfCompletedChallenges =>
      _challenges.where((challenge) => challenge.completed).length;

  List<dynamic> get challenges => _challenges;
  int get challengesLength => _challenges.length;

  Future<void> replaceChallenge(
      Challenge challengeToBeReplaced, int index) async {
    final storageServices = ref.read(storageServiceProvider);
    final challengesBox = storageServices.getAll(StorageBox.challengesBox);
    if (challengesBox.length == 0) {
      for (Challenge challenge in _challenges) {
        await ref.watch(storageServiceProvider).setValue(
            challenge.id.toString(), challenge, StorageBox.challengesBox);
      }
      await storageServices.deleteValue(
          challengeToBeReplaced.id.toString(), StorageBox.challengesBox);
    }

    state = storageServices.getAll(StorageBox.challengesBox);
  }

  void updateProgress(Challenge challenge) {
    challenge.progress++;
    final points = ref.read(pointsProvider);
    if (challenge.progress >= challenge.quantity) {
      challenge.completed = true;

      points.addPoints(Points.challengePoints);
    }

    if (challenge.completed) {
      //Give a price to user which is a badge that is shown in profile page
    }
  }

  void resetChallenges() {
    final initialChallenges = ref.read(challengesDataProvider);
    _challenges.clear();
    _challenges.addAll(initialChallenges);
    state = _challenges.toList();
  }

  DateTime currentWeekMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  DateTime currentWeekSunday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 7));
}
