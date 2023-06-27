import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ingredient.dart';
import 'measurement.dart';

part 'component.freezed.dart';
part 'component.g.dart';

@freezed
class Component extends HiveObject with _$Component {
  @HiveType(typeId: 4, adapterName: 'ComponentAdapter')
  factory Component({
    @HiveField(0) required int position,
    @HiveField(1) required Ingredient ingredient,
    @HiveField(2) List<Measurement>? measurements,
  }) = _Component;

  Component._();

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
}
