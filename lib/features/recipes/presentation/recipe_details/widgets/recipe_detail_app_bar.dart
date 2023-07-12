import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/providers/providers.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/is_saved_material_button.dart';
import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';
import 'app_bar_button.dart';

class RecipeDetailAppBar extends ConsumerWidget {
  const RecipeDetailAppBar({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      forceMaterialTransparency: true,
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: AppBarButton(
            asset: Assets.icons.back,
            onPressed: () {
              ref.invalidate(ingredientMultiplierProvider);
              ref.invalidate(instructionsCounterProvider);
              context.pop();
            }),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 10, 0),
          child: IsSavedMaterialButton(recipe: recipe),
        ),
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
    );
  }
}
