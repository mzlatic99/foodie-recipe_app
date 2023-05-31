// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
      id: json['id'] as int,
      imageUrl: json['thumbnail_url'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['total_time_minutes'] as int?,
      servings: json['num_servings'] as int?,
    );

Map<String, dynamic> _$$_RecipeToJson(_$_Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'thumbnail_url': instance.imageUrl,
      'name': instance.name,
      'description': instance.description,
      'instructions': instance.instructions,
      'sections': instance.sections,
      'total_time_minutes': instance.time,
      'num_servings': instance.servings,
    };
