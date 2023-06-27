// ignore_for_file: invalid_annotation_target

import 'recipe_instruction/recipe_instruction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'recipe_ingredients/section.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe extends HiveObject with _$Recipe {
  @HiveType(typeId: 1, adapterName: 'RecipeAdapter')
  factory Recipe({
    @HiveField(0) required int id,
    @JsonKey(name: 'thumbnail_url') @HiveField(1) required String imageUrl,
    @HiveField(2) required String name,
    @HiveField(3) required String description,
    @HiveField(4) required List<RecipeInstruction> instructions,
    @HiveField(5) required List<Section> sections,
    @JsonKey(name: 'total_time_minutes') @HiveField(6) int? time,
    @JsonKey(name: 'num_servings') @HiveField(7) int? servings,
  }) = _Recipe;

  Recipe._();

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
