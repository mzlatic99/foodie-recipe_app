import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api/dio_service.dart';
import '../features/recipes/data/http_recipe_repository.dart';

final dioServiceProvider = Provider<DioService>((ref) => DioService(ref));

final recipeRepositoryProvider = Provider<HttpRecipeRepository>(
  (ref) => HttpRecipeRepository(
    api: ref.read(
      dioServiceProvider,
    ),
  ),
);
