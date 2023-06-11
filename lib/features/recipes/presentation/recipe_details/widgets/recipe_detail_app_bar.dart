import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/router/router_context_extension.dart';

import '../../../../../theme/theme.dart';
import '../../../domain/recipe.dart';
import 'app_bar_button.dart';

class RecipeDetailAppBar extends StatelessWidget {
  const RecipeDetailAppBar({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
    );
  }
}
