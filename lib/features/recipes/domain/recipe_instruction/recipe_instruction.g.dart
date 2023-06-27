// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_instruction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeInstructionAdapter extends TypeAdapter<_$_RecipeInstruction> {
  @override
  final int typeId = 2;

  @override
  _$_RecipeInstruction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_RecipeInstruction(
      position: fields[0] as int,
      displayText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_RecipeInstruction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.position)
      ..writeByte(1)
      ..write(obj.displayText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeInstructionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RecipeInstruction _$$_RecipeInstructionFromJson(Map<String, dynamic> json) =>
    _$_RecipeInstruction(
      position: json['position'] as int,
      displayText: json['display_text'] as String,
    );

Map<String, dynamic> _$$_RecipeInstructionToJson(
        _$_RecipeInstruction instance) =>
    <String, dynamic>{
      'position': instance.position,
      'display_text': instance.displayText,
    };
