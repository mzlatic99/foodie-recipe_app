// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Measurement _$$_MeasurementFromJson(Map<String, dynamic> json) =>
    _$_Measurement(
      quantity: json['quantity'] as String,
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MeasurementToJson(_$_Measurement instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
