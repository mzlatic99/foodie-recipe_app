import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/router/router_context_extension.dart';
import '../../../../../common/is_saved_material_button.dart';
import '../../../domain/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../theme/theme.dart';

class RecipeWidget extends ConsumerWidget {
  const RecipeWidget({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.pushDetailPage(recipe: recipe),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16,
                ),
                color: ThemeColors.main),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          imageUrl: recipe.imageUrl,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.black26,
                            highlightColor: Colors.black12,
                            child: Container(
                              color: ThemeColors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: IsSavedMaterialButton(recipe: recipe)),
                    ],
                  ),
                ),
                Text(
                  recipe.name,
                  style: TextStyles.recipeName,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '15 bodova',
                        style: TextStyles.points,
                      ),
                      Text(
                        '${recipe.time != null ? (recipe.time != 0 ? recipe.time : '') : ''} ${recipe.time != null ? (recipe.time != 0 ? 'mins' : '') : ''}',
                        style: TextStyles.time,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
