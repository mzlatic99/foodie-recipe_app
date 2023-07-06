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
        icon: Assets.challanges.challage1,
        description: 'Skuhaj jedno jelo',
        quantity: 1,
        points: 10),
    Challenge(
        id: 1,
        name: 'Vege ljubitelj',
        icon: Assets.challanges.challage2,
        description: 'Iskoristi povrće u 3 jela',
        quantity: 3,
        points: 15),
    Challenge(
        id: 2,
        name: 'Majstor piletine',
        icon: Assets.challanges.challage3,
        description: 'Iskoristi piletinu u 3 jela',
        quantity: 3,
        points: 15),
    Challenge(
        id: 3,
        name: 'Sladokusac',
        icon: Assets.challanges.challage4,
        description: 'Napravi 1 desert',
        quantity: 1,
        points: 10),
  ];
}
