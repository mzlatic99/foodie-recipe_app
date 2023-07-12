import 'package:hive_flutter/hive_flutter.dart';

part 'reward.g.dart';

@HiveType(typeId: 10, adapterName: 'RewardAdapter')
class Reward extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(3)
  final String description;
  @HiveField(6)
  bool completed;
  @HiveField(7)
  int progress;

  Reward({
    required this.id,
    required this.name,
    required this.description,
    this.completed = false,
    this.progress = 0,
  });
}
