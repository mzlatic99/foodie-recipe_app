import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
class Ingredient extends HiveObject with _$Ingredient {
  @HiveType(typeId: 5, adapterName: 'IngredientAdapter')
  factory Ingredient({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
  }) = _Ingredient;

  Ingredient._();

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
