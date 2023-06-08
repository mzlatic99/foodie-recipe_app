import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:foodie/services/api/api_error.dart';
import '../../../authentification/presentation/auth_controller.dart';
import '../recipe_controller.dart';
import '../../../../theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/recipes_grid_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeList = ref.watch(recipeControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
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
                        'Pozdrav, Nikola',
                        style: TextStyles.text,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pripremi ukusna jela i osvoji nagrade!',
                        style: TextStyles.homePageMessage,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      authController.signOut();
                      context.goLogIn();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.avatars.male3,
                              width: 50,
                            ),
                            Text(
                              'Bodovi',
                              style: TextStyles.subtitle,
                            ),
                            Text(
                              '10 / 20',
                              style: TextStyles.points.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: ThemeColors.primary, width: 1),
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.icons.search),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Pretraži recepte', style: TextStyles.text),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Inspiracija',
                  style: TextStyles.title,
                ),
              ),
            ),
            recipeList.when(
              data: (recipes) => RecipesGridWidget(data: recipes),
              error: (e, __) => Text(
                (e as ApiError).toString(),
                textAlign: TextAlign.center,
                style: TextStyles.title,
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
