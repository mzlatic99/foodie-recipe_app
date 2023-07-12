import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/reward.dart';

final rewardsDataProvider = Provider<List<Reward>>((ref) {
  return RewardsData().data;
});

class RewardsData {
  final List<Reward> data = [
    Reward(id: 0, name: 'Budući chef', description: 'Napravi jedno jelo'),
    Reward(id: 1, name: 'Željezni kuhar', description: 'Ispuni 3 misije'),
    Reward(id: 2, name: 'Prep majstor', description: 'Spremi 2 recepta'),
    Reward(id: 3, name: 'Srebni lonac', description: 'Dosegni level 2'),
    Reward(id: 4, name: 'Srbija', description: 'Dosegni level 3'),
  ];
}
