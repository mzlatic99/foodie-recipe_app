// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

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
    required List<Map<String, dynamic>> sections,
    @JsonKey(name: 'total_time_minutes') required int time,
    @JsonKey(name: 'num_servings') required int servings,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}