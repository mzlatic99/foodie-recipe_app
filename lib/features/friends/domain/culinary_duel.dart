import '../../recipes/domain/recipe.dart';

enum DuelStatus { pending, accepted, declined }

class CulinaryDuel {
  final String senderUserId;
  final String receiverUserId;
  late final DuelStatus status;
  final Recipe? recipe;

  CulinaryDuel({
    required this.senderUserId,
    required this.receiverUserId,
    required this.status,
    this.recipe,
  });
}
