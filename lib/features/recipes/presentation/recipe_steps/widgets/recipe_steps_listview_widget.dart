import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';

class RecipeStepsListViewWidget extends StatelessWidget {
  const RecipeStepsListViewWidget({
    super.key,
    required this.recipe,
    required this.counterWatch,
  });

  final Recipe recipe;
  final int counterWatch;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: recipe.instructions.length,
        itemBuilder: (context, index) {
          final Color textColor = counterWatch <= index
              ? ThemeColors.inactiveStep
              : ThemeColors.main;
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    recipe.instructions[index].position.toString(),
                    style: TextStyles.mainText.copyWith(color: textColor),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    recipe.instructions[index].displayText,
                    style: TextStyles.mainText.copyWith(color: textColor),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
