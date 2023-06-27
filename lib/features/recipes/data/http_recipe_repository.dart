import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import 'recipe_repository.dart';
import '../domain/recipe.dart';
import '../domain/recipe_list.dart';
import '../../../services/api/dio_service.dart';
//import '../../../env/env.dart';

final recipeRepositoryProvider = Provider<HttpRecipeRepository>(
  (ref) => HttpRecipeRepository(
    api: ref.read(
      dioServiceProvider,
    ),
  ),
);

class HttpRecipeRepository implements RecipeRepository {
  HttpRecipeRepository({required this.api});
  final DioService api;

  @override
  Future<Recipe> getRecipe({required String id}) => api.request(
      // method: 'get',
      url: '/recipes/get-more-info',
      builder: (data) => Recipe.fromJson(data),
      parameters: {'id': id});

  @override
  Future<RecipeList> getRecipes({required int from, required int size}) =>
      api.request(
        // method: 'get',
        url: 'recipes/list',
        builder: (data) => RecipeList.fromJson(data),
        parameters: {'from': from, 'size': size},
      );

  @override
  Future<RecipeList> getFeed(
          {required int size,
          bool vegetarian = false,
          required int from,
          String timezone = '+0708'}) =>
      api.request(
        // method: 'get',
        url: 'feeds/list',
        builder: (data) => RecipeList.fromJson(data),
        parameters: {
          'size': '$size',
          'timezone': timezone,
          'vegetarian': '$vegetarian',
          'from': '$from'
        },
      );
}
