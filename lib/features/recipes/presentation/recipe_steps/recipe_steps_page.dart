import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/features/recipes/presentation/recipe_details/widgets/recipe_detail_app_bar.dart';
import 'package:foodie/router/app_router.dart';
import 'package:foodie/router/scaffold_with_bottom_nav_controller.dart';
import 'package:foodie/services/points/points.dart';

import '../../../../common/main_button_widget.dart';
import '../../../../constants/string_constants.dart';
import '../../../../router/app_route.dart';
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
      label: StringConstants.continueLabel,
      style: TextStyles.mainButton,
      onPressed: () {
        ref.watch(goRouterProvider)
          ..pop()
          ..pop();
      },
      backgorundColor: ThemeColors.primary,
    );

    Widget seeMoreButton = MainButtonWidget(
      label: StringConstants.seeRewards,
      style: TextStyles.secondaryAlertButtonLabel,
      onPressed: () {
        ref.watch(goRouterProvider)
          ..pop()
          ..pop()
          ..pop()
          ..goNamed(AppRoute.profile.name);
        ref.read(scaffoldBottomNavControllerProvider.notifier).setPosition(4);
      },
      backgorundColor: ThemeColors.white,
    );

    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: ThemeColors.main,
      title: Center(
        child: Text(
          StringConstants.wellDone,
          style: TextStyles.mainButton,
        ),
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+${Points.recipePoints} points from recipes',
              style: TextStyles.secondaryAlertButtonLabel,
            ),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: e,
                  ))
              .toList()),
      actions: [
        seeMoreButton,
        continueButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: _scaffoldKey.currentContext!,
      builder: (dialogContext) {
        return WillPopScope(
          onWillPop: () async => false,
          child: alert,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterWatch = ref.watch(instructionsCounterProvider);
    final counterRead = ref.read(instructionsCounterProvider.notifier);
    final pointsService = ref.read(pointsProvider);
    final challengesController = ref.read(challengeControllerProvider.notifier);
    final rewardsController = ref.read(rewardsControllerProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainButtonWidget(
        label: counterWatch < recipe.instructions.length
            ? StringConstants.next
            : StringConstants.end,
        style: TextStyles.mainButton,
        onPressed: () {
          if (counterWatch < recipe.instructions.length) {
            counterRead.state++;
          } else {
            pointsService.addPoints(Points.recipePoints);
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
