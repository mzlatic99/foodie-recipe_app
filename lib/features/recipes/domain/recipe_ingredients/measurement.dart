import 'package:freezed_annotation/freezed_annotation.dart';
import 'unit.dart';

part 'measurement.freezed.dart';
part 'measurement.g.dart';

@freezed
class Measurement with _$Measurement {
  factory Measurement({
    required String quantity,
    required Unit unit,
  }) = _Measurement;

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);
}
