// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Section _$$_SectionFromJson(Map<String, dynamic> json) => _$_Section(
      components: (json['components'] as List<dynamic>)
          .map((e) => Component.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SectionToJson(_$_Section instance) =>
    <String, dynamic>{
      'components': instance.components,
    };
