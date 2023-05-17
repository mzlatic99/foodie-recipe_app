// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RecipeList _$$_RecipeListFromJson(Map<String, dynamic> json) =>
    _$_RecipeList(
      results: (json['results'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RecipeListToJson(_$_RecipeList instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
