import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'component.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@freezed
class Section extends HiveObject with _$Section {
  @HiveType(typeId: 3, adapterName: 'SectionAdapter')
  factory Section({
    @HiveField(0) required List<Component> components,
  }) = _Section;

  Section._();

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
