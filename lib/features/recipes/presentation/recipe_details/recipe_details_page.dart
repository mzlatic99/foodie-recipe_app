import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/router/router_context_extension.dart';
import '../../../../common/main_button_widget.dart';
import '../../../../theme/theme.dart';
import '../../domain/recipe_ingredients/measurement.dart';
import '../../domain/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../extensions/string_capitalize_extension.dart';
import 'widgets/app_bar_button.dart';
import 'widgets/subtitle_horizontal_line.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainButtonWidget(
        label: 'Kuhaj!',
        style: TextStyles.mainButton,
        onPressed: () {},
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 3,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: AppBarButton(
                  asset: Assets.icons.back, onPressed: () => context.pop()),
            ),
            actions: [
              AppBarButton(asset: Assets.icons.save, onPressed: () {}),
              AppBarButton(asset: Assets.icons.share, onPressed: () {})
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: CachedNetworkImage(
                imageUrl: recipe.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                          '15 bodova',
                          style: TextStyles.points.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Opis recepta',
                      style: TextStyles.subtitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      recipe.description,
                      style: TextStyles.text,
                    ),
                  ),
                  const SubtitleHorizontalLine(label: 'Sastojci'),
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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                Assets.icons.subtract,
                                width: 25,
                              ),
                              Text(
                                '1',
                                style: TextStyles.text,
                              ),
                              SvgPicture.asset(
                                Assets.icons.add,
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    physics: const ScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: recipe.sections[0].components.length,
                    itemBuilder: (context, index) {
                      final String ingredientName =
                          recipe.sections[0].components[index].ingredient.name;
                      final List<Measurement> measure =
                          recipe.sections[0].components[index].measurements!;

                      return Row(
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              ingredientName.capitalize(),
                            ),
                          ),
                          measure.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "${measure[0].quantity == '0' ? '' : measure[0].quantity} ${measure[0].unit.name == '' ? '' : measure[0].unit.name}",
                                  ),
                                )
                              : const SizedBox.shrink()
                        ]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: e,
                                ))
                            .toList(),
                      );
                    },
                  ),
                  const SubtitleHorizontalLine(label: 'Komentari'),
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: e,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
