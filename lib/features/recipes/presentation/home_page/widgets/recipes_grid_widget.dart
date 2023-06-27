import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/recipe_list.dart';
import 'recipe_widget.dart';

class RecipesGridWidget extends ConsumerWidget {
  const RecipesGridWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  final RecipeList data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GridView.builder(
          itemCount: data.results.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            mainAxisExtent: 200,
          ),
          itemBuilder: (context, index) => RecipeWidget(
                recipe: data.results[index],
              )),
    );
  }
}
