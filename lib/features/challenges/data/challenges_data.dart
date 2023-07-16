import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/theme.dart';
import '../domain/challenge.dart';

final challengesDataProvider = Provider<List<Challenge>>((ref) {
  return ChallengesData().data;
});

class ChallengesData {
  final List<Challenge> data = [
    Challenge(
        id: 0,
        name: 'Početnik',
        icon: Assets.challenges.challenge1,
        description: 'Napravi jelo sa jajima',
        quantity: 1,
        points: 10),
    Challenge(
        id: 1,
        name: 'Vege ljubitelj',
        icon: Assets.challenges.challenge2,
        description: 'Iskoristi rajčicu ili salatu u 3 jela',
        quantity: 3,
        points: 15),
    Challenge(
        id: 2,
        name: 'Majstor piletine',
        icon: Assets.challenges.challenge3,
        description: 'Iskoristi piletinu u 3 jela',
        quantity: 3,
        points: 15),
    Challenge(
        id: 3,
        name: 'Sladokusac',
        icon: Assets.challenges.challenge4,
        description: 'Napravi desert sa čokoladom ili vanilijom',
        quantity: 1,
        points: 10),
  ];
}
