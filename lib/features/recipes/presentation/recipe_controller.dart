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
  int currentPage = 0;

  Future<void> getRecipes({String q = ''}) async {
    currentPage++;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final recipeData = recipeListRepository.getRecipes(
        from: currentPage * 10,
        size: 10,
        q: q,
      );
      return recipeData;
    });
  }
}
