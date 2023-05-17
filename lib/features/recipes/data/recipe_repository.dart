import '../domain/recipe.dart';
import '../domain/recipe_list.dart';

abstract class RecipeRepository {
  Future<RecipeList> getRecipes({required int from, required int size});
  Future<Recipe> getRecipe({required String id});
  Future<RecipeList> getFeed({required int size, bool vegetarian = false, required int from, String timezone = '+0708'});
}