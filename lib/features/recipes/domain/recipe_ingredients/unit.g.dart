// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnitAdapter extends TypeAdapter<_$_Unit> {
  @override
  final int typeId = 7;

  @override
  _$_Unit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Unit(
      system: fields[0] as String,
      name: fields[1] as String,
      abbreviation: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Unit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.system)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.abbreviation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Unit _$$_UnitFromJson(Map<String, dynamic> json) => _$_Unit(
      system: json['system'] as String,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String,
    );

Map<String, dynamic> _$$_UnitToJson(_$_Unit instance) => <String, dynamic>{
      'system': instance.system,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
    };
