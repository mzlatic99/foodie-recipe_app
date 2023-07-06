import 'package:hive_flutter/hive_flutter.dart';

part 'challenge.g.dart';

@HiveType(typeId: 8, adapterName: 'ChallengeAdapter')
class Challenge extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String icon;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final int quantity;
  @HiveField(5)
  final int points;
  @HiveField(6)
  bool completed;
  @HiveField(7)
  int progress;

  Challenge({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.points,
    required this.quantity,
    this.completed = false,
    this.progress = 0,
  });
}
