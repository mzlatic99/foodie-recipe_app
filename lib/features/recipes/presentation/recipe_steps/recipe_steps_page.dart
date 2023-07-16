import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/features/recipes/presentation/recipe_details/widgets/recipe_detail_app_bar.dart';
import 'package:foodie/router/app_router.dart';
import 'package:foodie/services/points/points.dart';

import '../../../../common/main_button_widget.dart';
import '../../../../theme/theme.dart';
import '../../../rewards/controller/rewards_controller.dart';
import '../../domain/recipe.dart';
import '../recipe_details/widgets/recipe_name_and_points.dart';
import '../../../../providers/providers.dart';
import 'widgets/recipe_steps_listview_widget.dart';

class RecipeStepsPage extends ConsumerWidget {
  RecipeStepsPage({super.key, required this.recipe});
  final Recipe recipe;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  showAlertDialog(WidgetRef ref) {
    Widget continueButton = MainButtonWidget(
      label: 'Nastavi',
      style: TextStyles.mainButton,
      onPressed: () {
        ref.read(goRouterProvider)
          ..pop()
          ..pop();
      },
      backgorundColor: ThemeColors.primary,
    );

    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: ThemeColors.main,
      title: Center(
        child: Text(
          'Bravo!',
          style: TextStyles.mainButton,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* Text(
            'Otključao si novu hrantastičnu činjenicu',
            style: TextStyles.mainButton,
          ), */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child:
                Text('+10 bodova', style: TextStyles.secondaryAlertButtonLabel),
          ),
          /* Text(
            'Špinat sadrži manje željeza nego što se misli. Špinatov ugled kao bogat izvor željeza temelji se na pogrešci u znanstvenom istraživanju iz 19. stoljeća. Tijekom jednog istraživanja, decimalni zarez bio je pogrešno postavljen, što je rezultiralo deset puta većom vrijednošću željeza nego što špinat zapravo sadrži.',
            style: TextStyles.alertText,
          ), */
        ],
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (dialogContext) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterWatch = ref.watch(instructionsCounterProvider);
    final counterRead = ref.read(instructionsCounterProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainButtonWidget(
        label: counterWatch < recipe.instructions.length ? 'Sljedeći' : 'Kraj',
        style: TextStyles.mainButton,
        onPressed: () {
          if (counterWatch < recipe.instructions.length) {
            counterRead.state++;
          } else {
            final pointsService = ref.read(pointsProvider);
            pointsService.addPoints(Points.recipePoints);
            final challengesController =
                ref.read(challengeControllerProvider.notifier);
            final rewardsController =
                ref.read(rewardsControllerProvider.notifier);
            challengesController.checkChallengesConditions(recipe);
            rewardsController.checkRewardConditions();
            showAlertDialog(ref);
          }
        },
        backgorundColor: ThemeColors.primary,
      ),
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
