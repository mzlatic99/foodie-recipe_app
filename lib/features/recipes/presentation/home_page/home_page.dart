import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/services/api/api_error.dart';
import 'package:foodie/services/points/points.dart';
import 'package:foodie/utils/async_value_ui_extension.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';
import '../../../../common/search_field_widget.dart';
import '../../../../constants/string_constants.dart';
import '../../../../providers/providers.dart';
import '../recipe_controller.dart';
import '../../../../theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/recipes_grid_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);
    ref.read(storageServiceProvider).user = auth.currentUser!.email!;
    final recipeController = ref.watch(recipeControllerProvider);
    final totalPoints = ref.watch(pointsProvider);

    ref.listen<AsyncValue>(
      recipeControllerProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${StringConstants.hello}, ${auth.currentUser?.displayName}',
                          style: TextStyles.text,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          StringConstants.homeMessage,
                          style: TextStyles.homePageMessage,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              auth.currentUser?.photoURL ??
                                  Assets.avatars.avatar0,
                              width: 50,
                            ),
                            Text(
                              StringConstants.points,
                              style: TextStyles.subtitle,
                            ),
                            Text(
                              '${totalPoints.getTotalPoints()}',
                              style: TextStyles.mainText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SearchFieldWidget(
                  onPressed: () {}, label: StringConstants.searchRecipes),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    StringConstants.inspiration,
                    style: TextStyles.title,
                  ),
                ),
              ),
              recipeController.when(
                data: (recipes) => RecipesGridWidget(data: recipes),
                error: (e, __) => Text(
                  (e as ApiError).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyles.title,
                ),
                loading: () => const Center(
                  child: Loader(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
