// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecipeList _$RecipeListFromJson(Map<String, dynamic> json) {
  return _RecipeList.fromJson(json);
}

/// @nodoc
mixin _$RecipeList {
  List<Recipe> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeListCopyWith<RecipeList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeListCopyWith<$Res> {
  factory $RecipeListCopyWith(
          RecipeList value, $Res Function(RecipeList) then) =
      _$RecipeListCopyWithImpl<$Res, RecipeList>;
  @useResult
  $Res call({List<Recipe> results});
}

/// @nodoc
class _$RecipeListCopyWithImpl<$Res, $Val extends RecipeList>
    implements $RecipeListCopyWith<$Res> {
  _$RecipeListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeListCopyWith<$Res>
    implements $RecipeListCopyWith<$Res> {
  factory _$$_RecipeListCopyWith(
          _$_RecipeList value, $Res Function(_$_RecipeList) then) =
      __$$_RecipeListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Recipe> results});
}

/// @nodoc
class __$$_RecipeListCopyWithImpl<$Res>
    extends _$RecipeListCopyWithImpl<$Res, _$_RecipeList>
    implements _$$_RecipeListCopyWith<$Res> {
  __$$_RecipeListCopyWithImpl(
      _$_RecipeList _value, $Res Function(_$_RecipeList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$_RecipeList(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecipeList implements _RecipeList {
  _$_RecipeList({required final List<Recipe> results}) : _results = results;

  factory _$_RecipeList.fromJson(Map<String, dynamic> json) =>
      _$$_RecipeListFromJson(json);

  final List<Recipe> _results;
  @override
  List<Recipe> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'RecipeList(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipeList &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeListCopyWith<_$_RecipeList> get copyWith =>
      __$$_RecipeListCopyWithImpl<_$_RecipeList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecipeListToJson(
      this,
    );
  }
}

abstract class _RecipeList implements RecipeList {
  factory _RecipeList({required final List<Recipe> results}) = _$_RecipeList;

  factory _RecipeList.fromJson(Map<String, dynamic> json) =
      _$_RecipeList.fromJson;

  @override
  List<Recipe> get results;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeListCopyWith<_$_RecipeList> get copyWith =>
      throw _privateConstructorUsedError;
}
