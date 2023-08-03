import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';

class RecipeNameAndPoints extends StatelessWidget {
  const RecipeNameAndPoints({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Flexible(
            child: Text(
              recipe.name,
              style: TextStyles.title,
            ),
          ),
          Text(
            '10 points',
            style: TextStyles.points.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
