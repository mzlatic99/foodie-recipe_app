import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/challenges_data_constants.dart';
import '../../../theme/theme.dart';
import '../domain/challenge.dart';

final challengesDataProvider = Provider<List<Challenge>>((ref) {
  return ChallengesData().data;
});

class ChallengesData {
  final List<Challenge> data = [
    Challenge(
        id: 0,
        name: ChallengesDataConstants.beginner,
        icon: Assets.challenges.challenge1,
        description: ChallengesDataConstants.beginnerDesc,
        quantity: 1,
        points: 10),
    Challenge(
        id: 1,
        name: ChallengesDataConstants.veggieLover,
        icon: Assets.challenges.challenge2,
        description: ChallengesDataConstants.veggieLoverDesc,
        quantity: 3,
        points: 15),
    Challenge(
        id: 2,
        name: ChallengesDataConstants.chickenMaster,
        icon: Assets.challenges.challenge3,
        description: ChallengesDataConstants.chickenMasterDesc,
        quantity: 3,
        points: 15),
    Challenge(
        id: 3,
        name: ChallengesDataConstants.sweetTooth,
        icon: Assets.challenges.challenge4,
        description: ChallengesDataConstants.sweetToothDesc,
        quantity: 1,
        points: 10),
  ];
}
