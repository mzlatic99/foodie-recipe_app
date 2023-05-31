// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Component _$$_ComponentFromJson(Map<String, dynamic> json) => _$_Component(
      position: json['position'] as int,
      ingredient:
          Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
      measurements: (json['measurements'] as List<dynamic>?)
          ?.map((e) => Measurement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ComponentToJson(_$_Component instance) =>
    <String, dynamic>{
      'position': instance.position,
      'ingredient': instance.ingredient,
      'measurements': instance.measurements,
    };
