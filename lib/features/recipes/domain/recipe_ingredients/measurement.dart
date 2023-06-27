import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'unit.dart';

part 'measurement.freezed.dart';
part 'measurement.g.dart';

@freezed
class Measurement extends HiveObject with _$Measurement {
  @HiveType(typeId: 6, adapterName: 'MeasurementAdapter')
  factory Measurement({
    @HiveField(0) required String quantity,
    @HiveField(1) required Unit unit,
  }) = _Measurement;

  Measurement._();

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);
}
