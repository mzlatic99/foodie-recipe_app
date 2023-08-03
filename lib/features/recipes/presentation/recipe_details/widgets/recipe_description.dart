import 'package:flutter/material.dart';

import '../../../../../constants/string_constants.dart';
import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';

class RecipeDescription extends StatelessWidget {
  const RecipeDescription({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            StringConstants.description,
            style: TextStyles.subtitle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              recipe.description,
              style: TextStyles.text,
            ),
          ),
        ],
      ),
    );
  }
}
