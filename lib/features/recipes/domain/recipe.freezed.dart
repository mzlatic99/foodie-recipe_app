// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_url')
  @HiveField(1)
  String get imageUrl => throw _privateConstructorUsedError;
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;
  @HiveField(3)
  String get description => throw _privateConstructorUsedError;
  @HiveField(4)
  List<RecipeInstruction> get instructions =>
      throw _privateConstructorUsedError;
  @HiveField(5)
  List<Section> get sections => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_minutes')
  @HiveField(6)
  int? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_servings')
  @HiveField(7)
  int? get servings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @JsonKey(name: 'thumbnail_url') @HiveField(1) String imageUrl,
      @HiveField(2) String name,
      @HiveField(3) String description,
      @HiveField(4) List<RecipeInstruction> instructions,
      @HiveField(5) List<Section> sections,
      @JsonKey(name: 'total_time_minutes') @HiveField(6) int? time,
      @JsonKey(name: 'num_servings') @HiveField(7) int? servings});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? name = null,
    Object? description = null,
    Object? instructions = null,
    Object? sections = null,
    Object? time = freezed,
    Object? servings = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<RecipeInstruction>,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$_RecipeCopyWith(_$_Recipe value, $Res Function(_$_Recipe) then) =
      __$$_RecipeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @JsonKey(name: 'thumbnail_url') @HiveField(1) String imageUrl,
      @HiveField(2) String name,
      @HiveField(3) String description,
      @HiveField(4) List<RecipeInstruction> instructions,
      @HiveField(5) List<Section> sections,
      @JsonKey(name: 'total_time_minutes') @HiveField(6) int? time,
      @JsonKey(name: 'num_servings') @HiveField(7) int? servings});
}

/// @nodoc
class __$$_RecipeCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$_Recipe>
    implements _$$_RecipeCopyWith<$Res> {
  __$$_RecipeCopyWithImpl(_$_Recipe _value, $Res Function(_$_Recipe) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? name = null,
    Object? description = null,
    Object? instructions = null,
    Object? sections = null,
    Object? time = freezed,
    Object? servings = freezed,
  }) {
    return _then(_$_Recipe(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<RecipeInstruction>,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'RecipeAdapter')
class _$_Recipe extends _Recipe {
  _$_Recipe(
      {@HiveField(0) required this.id,
      @JsonKey(name: 'thumbnail_url') @HiveField(1) required this.imageUrl,
      @HiveField(2) required this.name,
      @HiveField(3) required this.description,
      @HiveField(4) required final List<RecipeInstruction> instructions,
      @HiveField(5) required final List<Section> sections,
      @JsonKey(name: 'total_time_minutes') @HiveField(6) this.time,
      @JsonKey(name: 'num_servings') @HiveField(7) this.servings})
      : _instructions = instructions,
        _sections = sections,
        super._();

  factory _$_Recipe.fromJson(Map<String, dynamic> json) =>
      _$$_RecipeFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @JsonKey(name: 'thumbnail_url')
  @HiveField(1)
  final String imageUrl;
  @override
  @HiveField(2)
  final String name;
  @override
  @HiveField(3)
  final String description;
  final List<RecipeInstruction> _instructions;
  @override
  @HiveField(4)
  List<RecipeInstruction> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  final List<Section> _sections;
  @override
  @HiveField(5)
  List<Section> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  @JsonKey(name: 'total_time_minutes')
  @HiveField(6)
  final int? time;
  @override
  @JsonKey(name: 'num_servings')
  @HiveField(7)
  final int? servings;

  @override
  String toString() {
    return 'Recipe(id: $id, imageUrl: $imageUrl, name: $name, description: $description, instructions: $instructions, sections: $sections, time: $time, servings: $servings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recipe &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.servings, servings) ||
                other.servings == servings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      imageUrl,
      name,
      description,
      const DeepCollectionEquality().hash(_instructions),
      const DeepCollectionEquality().hash(_sections),
      time,
      servings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeCopyWith<_$_Recipe> get copyWith =>
      __$$_RecipeCopyWithImpl<_$_Recipe>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecipeToJson(
      this,
    );
  }
}

abstract class _Recipe extends Recipe {
  factory _Recipe(
      {@HiveField(0)
          required final int id,
      @JsonKey(name: 'thumbnail_url')
      @HiveField(1)
          required final String imageUrl,
      @HiveField(2)
          required final String name,
      @HiveField(3)
          required final String description,
      @HiveField(4)
          required final List<RecipeInstruction> instructions,
      @HiveField(5)
          required final List<Section> sections,
      @JsonKey(name: 'total_time_minutes')
      @HiveField(6)
          final int? time,
      @JsonKey(name: 'num_servings')
      @HiveField(7)
          final int? servings}) = _$_Recipe;
  _Recipe._() : super._();

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$_Recipe.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @JsonKey(name: 'thumbnail_url')
  @HiveField(1)
  String get imageUrl;
  @override
  @HiveField(2)
  String get name;
  @override
  @HiveField(3)
  String get description;
  @override
  @HiveField(4)
  List<RecipeInstruction> get instructions;
  @override
  @HiveField(5)
  List<Section> get sections;
  @override
  @JsonKey(name: 'total_time_minutes')
  @HiveField(6)
  int? get time;
  @override
  @JsonKey(name: 'num_servings')
  @HiveField(7)
  int? get servings;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeCopyWith<_$_Recipe> get copyWith =>
      throw _privateConstructorUsedError;
}
