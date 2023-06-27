// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Component _$ComponentFromJson(Map<String, dynamic> json) {
  return _Component.fromJson(json);
}

/// @nodoc
mixin _$Component {
  @HiveField(0)
  int get position => throw _privateConstructorUsedError;
  @HiveField(1)
  Ingredient get ingredient => throw _privateConstructorUsedError;
  @HiveField(2)
  List<Measurement>? get measurements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComponentCopyWith<Component> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentCopyWith<$Res> {
  factory $ComponentCopyWith(Component value, $Res Function(Component) then) =
      _$ComponentCopyWithImpl<$Res, Component>;
  @useResult
  $Res call(
      {@HiveField(0) int position,
      @HiveField(1) Ingredient ingredient,
      @HiveField(2) List<Measurement>? measurements});

  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class _$ComponentCopyWithImpl<$Res, $Val extends Component>
    implements $ComponentCopyWith<$Res> {
  _$ComponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? ingredient = null,
    Object? measurements = freezed,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<Measurement>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IngredientCopyWith<$Res> get ingredient {
    return $IngredientCopyWith<$Res>(_value.ingredient, (value) {
      return _then(_value.copyWith(ingredient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ComponentCopyWith<$Res> implements $ComponentCopyWith<$Res> {
  factory _$$_ComponentCopyWith(
          _$_Component value, $Res Function(_$_Component) then) =
      __$$_ComponentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int position,
      @HiveField(1) Ingredient ingredient,
      @HiveField(2) List<Measurement>? measurements});

  @override
  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class __$$_ComponentCopyWithImpl<$Res>
    extends _$ComponentCopyWithImpl<$Res, _$_Component>
    implements _$$_ComponentCopyWith<$Res> {
  __$$_ComponentCopyWithImpl(
      _$_Component _value, $Res Function(_$_Component) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? ingredient = null,
    Object? measurements = freezed,
  }) {
    return _then(_$_Component(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      measurements: freezed == measurements
          ? _value._measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<Measurement>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4, adapterName: 'ComponentAdapter')
class _$_Component extends _Component {
  _$_Component(
      {@HiveField(0) required this.position,
      @HiveField(1) required this.ingredient,
      @HiveField(2) final List<Measurement>? measurements})
      : _measurements = measurements,
        super._();

  factory _$_Component.fromJson(Map<String, dynamic> json) =>
      _$$_ComponentFromJson(json);

  @override
  @HiveField(0)
  final int position;
  @override
  @HiveField(1)
  final Ingredient ingredient;
  final List<Measurement>? _measurements;
  @override
  @HiveField(2)
  List<Measurement>? get measurements {
    final value = _measurements;
    if (value == null) return null;
    if (_measurements is EqualUnmodifiableListView) return _measurements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Component(position: $position, ingredient: $ingredient, measurements: $measurements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Component &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient) &&
            const DeepCollectionEquality()
                .equals(other._measurements, _measurements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, ingredient,
      const DeepCollectionEquality().hash(_measurements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ComponentCopyWith<_$_Component> get copyWith =>
      __$$_ComponentCopyWithImpl<_$_Component>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ComponentToJson(
      this,
    );
  }
}

abstract class _Component extends Component {
  factory _Component(
      {@HiveField(0) required final int position,
      @HiveField(1) required final Ingredient ingredient,
      @HiveField(2) final List<Measurement>? measurements}) = _$_Component;
  _Component._() : super._();

  factory _Component.fromJson(Map<String, dynamic> json) =
      _$_Component.fromJson;

  @override
  @HiveField(0)
  int get position;
  @override
  @HiveField(1)
  Ingredient get ingredient;
  @override
  @HiveField(2)
  List<Measurement>? get measurements;
  @override
  @JsonKey(ignore: true)
  _$$_ComponentCopyWith<_$_Component> get copyWith =>
      throw _privateConstructorUsedError;
}
