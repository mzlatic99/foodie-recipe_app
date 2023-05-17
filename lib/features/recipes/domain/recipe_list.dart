import 'package:freezed_annotation/freezed_annotation.dart';

import 'recipe.dart';

part 'recipe_list.freezed.dart';
part 'recipe_list.g.dart';

@freezed
class RecipeList with _$RecipeList {
  factory RecipeList({
    required List<Recipe> results,
  }) = _RecipeList;

  factory RecipeList.fromJson(Map<String, dynamic> json) => _$RecipeListFromJson(json);
}