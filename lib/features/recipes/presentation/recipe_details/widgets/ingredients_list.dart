import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/providers/providers.dart';
import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';
import '../../../domain/recipe_ingredients/measurement.dart';
import '../ingredient_controller.dart';
import 'ingredient_with_measure_row_widget.dart';

class IngredientsList extends ConsumerWidget {
  const IngredientsList({
    super.key,
    required this.recipe,
  });
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multiplierRead = ref.read(ingredientMultiplierProvider.notifier);
    final multiplierWatch = ref.watch(ingredientMultiplierProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Broj osoba:'.toUpperCase(),
                  style: TextStyles.text,
                ),
              ),
              // TODO: implement scaling with number of service instead of people, take original serving from api and calculate with it
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          multiplierWatch > 1 ? multiplierRead.state-- : null,
                      child: SvgPicture.asset(
                        Assets.icons.subtract,
                        width: 25,
                      ),
                    ),
                    Text(
                      multiplierWatch.toString(),
                      style: TextStyles.text,
                    ),
                    GestureDetector(
                      onTap: () => multiplierRead.state++,
                      child: SvgPicture.asset(
                        Assets.icons.add,
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          shrinkWrap: true,
          itemCount: recipe.sections[0].components.length,
          itemBuilder: (context, index) {
            final String ingredientName =
                recipe.sections[0].components[index].ingredient.name;
            final List<Measurement> measure =
                recipe.sections[0].components[index].measurements!;
            final measureQuantity = measure[0].quantity;
            final measureUnit = measure[0].unit.name;
            final ingredientController =
                ref.watch(ingredientControllerProvider);
            final measureQuantityValue =
                ingredientController.getCalculation(measureQuantity);
            final measureQuantityResult = switch (measureQuantityValue) {
              Success(value: final quantity) => quantity.toString(),
              Failure(exception: final exception) => exception.toString()
            };

            return IngredientWithMeasureRowWidget(
              ingredientName: ingredientName,
              measure: measure,
              measureQuantity: measureQuantity,
              measureQuantityResult: measureQuantityResult,
              measureUnit: measureUnit,
            );
          },
        ),
      ],
    );
  }
}
