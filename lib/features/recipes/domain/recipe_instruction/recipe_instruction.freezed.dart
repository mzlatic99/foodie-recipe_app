// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecipeInstruction _$RecipeInstructionFromJson(Map<String, dynamic> json) {
  return _RecipeInstruction.fromJson(json);
}

/// @nodoc
mixin _$RecipeInstruction {
  @HiveField(0)
  int get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_text')
  @HiveField(1)
  String get displayText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeInstructionCopyWith<RecipeInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeInstructionCopyWith<$Res> {
  factory $RecipeInstructionCopyWith(
          RecipeInstruction value, $Res Function(RecipeInstruction) then) =
      _$RecipeInstructionCopyWithImpl<$Res, RecipeInstruction>;
  @useResult
  $Res call(
      {@HiveField(0) int position,
      @JsonKey(name: 'display_text') @HiveField(1) String displayText});
}

/// @nodoc
class _$RecipeInstructionCopyWithImpl<$Res, $Val extends RecipeInstruction>
    implements $RecipeInstructionCopyWith<$Res> {
  _$RecipeInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? displayText = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      displayText: null == displayText
          ? _value.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeInstructionCopyWith<$Res>
    implements $RecipeInstructionCopyWith<$Res> {
  factory _$$_RecipeInstructionCopyWith(_$_RecipeInstruction value,
          $Res Function(_$_RecipeInstruction) then) =
      __$$_RecipeInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int position,
      @JsonKey(name: 'display_text') @HiveField(1) String displayText});
}

/// @nodoc
class __$$_RecipeInstructionCopyWithImpl<$Res>
    extends _$RecipeInstructionCopyWithImpl<$Res, _$_RecipeInstruction>
    implements _$$_RecipeInstructionCopyWith<$Res> {
  __$$_RecipeInstructionCopyWithImpl(
      _$_RecipeInstruction _value, $Res Function(_$_RecipeInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? displayText = null,
  }) {
    return _then(_$_RecipeInstruction(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      displayText: null == displayText
          ? _value.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'RecipeInstructionAdapter')
class _$_RecipeInstruction extends _RecipeInstruction {
  _$_RecipeInstruction(
      {@HiveField(0) required this.position,
      @JsonKey(name: 'display_text') @HiveField(1) required this.displayText})
      : super._();

  factory _$_RecipeInstruction.fromJson(Map<String, dynamic> json) =>
      _$$_RecipeInstructionFromJson(json);

  @override
  @HiveField(0)
  final int position;
  @override
  @JsonKey(name: 'display_text')
  @HiveField(1)
  final String displayText;

  @override
  String toString() {
    return 'RecipeInstruction(position: $position, displayText: $displayText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipeInstruction &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.displayText, displayText) ||
                other.displayText == displayText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, displayText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeInstructionCopyWith<_$_RecipeInstruction> get copyWith =>
      __$$_RecipeInstructionCopyWithImpl<_$_RecipeInstruction>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecipeInstructionToJson(
      this,
    );
  }
}

abstract class _RecipeInstruction extends RecipeInstruction {
  factory _RecipeInstruction(
      {@HiveField(0)
          required final int position,
      @JsonKey(name: 'display_text')
      @HiveField(1)
          required final String displayText}) = _$_RecipeInstruction;
  _RecipeInstruction._() : super._();

  factory _RecipeInstruction.fromJson(Map<String, dynamic> json) =
      _$_RecipeInstruction.fromJson;

  @override
  @HiveField(0)
  int get position;
  @override
  @JsonKey(name: 'display_text')
  @HiveField(1)
  String get displayText;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeInstructionCopyWith<_$_RecipeInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
