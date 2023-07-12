import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/recipe_list.dart';
import '../data/http_recipe_repository.dart';

final currentScrollValue = Provider<int>((ref) => 1);

final recipeControllerProvider =
    StateNotifierProvider<RecipeController, AsyncValue<RecipeList>>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  return RecipeController(ref, recipeRepository);
});

class RecipeController extends StateNotifier<AsyncValue<RecipeList>> {
  RecipeController(this.ref, this.recipeListRepository)
      : super(const AsyncLoading()) {
    getRecipes();
  }
  final HttpRecipeRepository recipeListRepository;
  final Ref ref;

  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> getRecipes() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final recipeData =
          await recipeListRepository.getRecipes(from: 0, size: 8);
      return recipeData;
    });
  }
}
