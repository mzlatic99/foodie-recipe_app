import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'measurement.dart';

part 'component.freezed.dart';
part 'component.g.dart';

@freezed
class Component with _$Component {
  factory Component({
    required int position,
    required Ingredient ingredient,
    List<Measurement>? measurements,
  }) = _Component;

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
}
