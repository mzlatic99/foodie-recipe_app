// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'recipe_ingredients/section.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  factory Recipe({
    required int id,
    @JsonKey(name: 'thumbnail_url') required String imageUrl,
    required String name,
    required String description,
    required List<Map> instructions,
    required List<Section> sections,
    @JsonKey(name: 'total_time_minutes') int? time,
    @JsonKey(name: 'num_servings') int? servings,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
