// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'recipe_instruction.freezed.dart';
part 'recipe_instruction.g.dart';

@freezed
class RecipeInstruction extends HiveObject with _$RecipeInstruction {
  @HiveType(typeId: 2, adapterName: 'RecipeInstructionAdapter')
  factory RecipeInstruction({
    @HiveField(0) required int position,
    @JsonKey(name: 'display_text') @HiveField(1) required String displayText,
  }) = _RecipeInstruction;

  RecipeInstruction._();

  factory RecipeInstruction.fromJson(Map<String, dynamic> json) =>
      _$RecipeInstructionFromJson(json);
}
