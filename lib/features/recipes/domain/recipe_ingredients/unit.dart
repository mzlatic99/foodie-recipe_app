import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'unit.freezed.dart';
part 'unit.g.dart';

@freezed
class Unit extends HiveObject with _$Unit {
  @HiveType(typeId: 7, adapterName: 'UnitAdapter')
  factory Unit({
    @HiveField(0) required String system,
    @HiveField(1) required String name,
    @HiveField(2) required String abbreviation,
  }) = _Unit;

  Unit._();

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}
