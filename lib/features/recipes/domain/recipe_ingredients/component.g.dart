// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComponentAdapter extends TypeAdapter<_$_Component> {
  @override
  final int typeId = 4;

  @override
  _$_Component read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Component(
      position: fields[0] as int,
      ingredient: fields[1] as Ingredient,
      measurements: (fields[2] as List?)?.cast<Measurement>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_Component obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.position)
      ..writeByte(1)
      ..write(obj.ingredient)
      ..writeByte(2)
      ..write(obj.measurements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
