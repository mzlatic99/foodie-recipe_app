import 'package:flutter/material.dart';
import 'package:foodie/utils/string_capitalize_extension.dart';

import '../../../domain/recipe_ingredients/measurement.dart';

class IngredientWithMeasureRowWidget extends StatelessWidget {
  const IngredientWithMeasureRowWidget({
    super.key,
    required this.ingredientName,
    required this.measure,
    required this.measureQuantity,
    required this.measureQuantityResult,
    required this.measureUnit,
  });

  final String ingredientName;
  final List<Measurement> measure;
  final String measureQuantity;
  final String measureQuantityResult;
  final String measureUnit;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            ingredientName.capitalize(),
          ),
        ),
        measure.isNotEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  "${measureQuantity == '0' ? '' : measureQuantityResult} ${measureUnit == '' ? '' : measureUnit}",
                ),
              )
            : const SizedBox.shrink()
      ]
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: e,
              ))
          .toList(),
    );
  }
}
