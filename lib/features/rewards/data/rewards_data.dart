import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/reward_data_constants.dart';
import '../domain/reward.dart';

final rewardsDataProvider = Provider<List<Reward>>((ref) {
  return RewardsData().data;
});

class RewardsData {
  final List<Reward> data = [
    Reward(
        id: 0,
        name: RewardDataConstants.futureChef,
        description: RewardDataConstants.futureChefDesc),
    Reward(
        id: 1,
        name: RewardDataConstants.ironChef,
        description: RewardDataConstants.ironChefDesc),
    Reward(
        id: 2,
        name: RewardDataConstants.prepMaster,
        description: RewardDataConstants.prepMasterDesc),
    Reward(
        id: 3,
        name: RewardDataConstants.silverPot,
        description: RewardDataConstants.silverPotDesc),
    Reward(
        id: 4,
        name: RewardDataConstants.goldenPasta,
        description: RewardDataConstants.goldenPastaDesc),
  ];
}
