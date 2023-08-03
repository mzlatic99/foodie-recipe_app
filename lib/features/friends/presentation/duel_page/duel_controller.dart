import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/friends/presentation/chat_page/chat_controller.dart';
import 'package:foodie/features/recipes/data/http_recipe_repository.dart';

import '../../../../constants/message_type_constants.dart';
import '../../../recipes/domain/recipe.dart';
import '../../data/duel_repository.dart';

final duelControllerProvider =
    StateNotifierProvider.autoDispose<DuelController, AsyncValue<Recipe?>>(
        (ref) {
  final duelRepository = ref.read(culinaryDuelRepositoryProvider);
  return DuelController(ref, duelRepository);
});

class DuelController extends StateNotifier<AsyncValue<Recipe?>> {
  DuelController(this.ref, this.duelRepository) : super(const AsyncLoading());

  final DuelRepository duelRepository;
  final Ref ref;

  Future<void> sendDuel(String roomId, String userId) async {
    final friendsController = ref.read(chatControllerProvider.notifier);
    await friendsController.sendMessage(
        state.value!.id.toString(), MessageType.duel, roomId, userId);
  }

  Future<void> chooseRandomRecipe() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      Recipe? randomRecipe = await getRandomRecipe();
      while (randomRecipe == null) {
        randomRecipe = await getRandomRecipe();
      }
      return randomRecipe;
    });
  }

  Future<Recipe?> getRandomRecipe() async {
    final random = Random();
    final recipeData = await ref
        .watch(recipeRepositoryProvider)
        .getRecipe(id: (random.nextInt(7001) + 1000).toString());
    return recipeData;
  }

  Future<Recipe?> getRecipe(String id) async {
    final recipeData =
        await ref.watch(recipeRepositoryProvider).getRecipe(id: id);
    return recipeData;
  }
}
