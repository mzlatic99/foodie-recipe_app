// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<_$_Recipe> {
  @override
  final int typeId = 1;

  @override
  _$_Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Recipe(
      id: fields[0] as int,
      imageUrl: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      instructions: (fields[4] as List).cast<RecipeInstruction>(),
      sections: (fields[5] as List).cast<Section>(),
      time: fields[6] as int?,
      servings: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Recipe obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.servings)
      ..writeByte(4)
      ..write(obj.instructions)
      ..writeByte(5)
      ..write(obj.sections);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
      id: json['id'] as int,
      imageUrl: json['thumbnail_url'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => RecipeInstruction.fromJson(e as Map<String, dynamic>))
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
