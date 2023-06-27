import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/recipes/presentation/recipe_details/widgets/recipe_detail_app_bar.dart';

import '../../../../common/main_button_widget.dart';
import '../../../../theme/theme.dart';
import '../../domain/recipe.dart';
import '../recipe_details/widgets/recipe_name_and_points.dart';
import '../../../../providers/providers.dart';
import 'widgets/recipe_steps_listview_widget.dart';

class RecipeStepsPage extends ConsumerWidget {
  const RecipeStepsPage({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterWatch = ref.watch(instructionsCounterProvider);
    final counterRead = ref.read(instructionsCounterProvider.notifier);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainButtonWidget(
          label:
              counterWatch < recipe.instructions.length ? 'Sljedeći' : 'Kraj',
          style: TextStyles.mainButton,
          onPressed: () => counterRead.state++),
      body: CustomScrollView(slivers: [
        RecipeDetailAppBar(recipe: recipe),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeNameAndPoints(recipe: recipe),
                RecipeStepsListViewWidget(
                    recipe: recipe, counterWatch: counterWatch),
                const SizedBox(
                  height: 20,
                ),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
