import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/storage_box_constants.dart';
import 'package:foodie/providers/providers.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/string_constants.dart';
import '../../../../services/points/points.dart';
import '../../../../theme/theme.dart';
import '../../domain/recipe.dart';

class SavedRecipesPage extends ConsumerWidget {
  const SavedRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageService = ref.watch(storageServiceProvider);
    final imageSize = MediaQuery.of(context).size.width * 0.3;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            StringConstants.savedRecipes,
            style: TextStyles.title,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: storageService
                        .getLength<Recipe>(StorageBox.favoritesBox),
                    itemBuilder: (context, index) {
                      final recipe = storageService
                          .getAll<Recipe>(StorageBox.favoritesBox)[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: GestureDetector(
                          onTap: () => context.pushDetailPage(recipe: recipe),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  width: imageSize,
                                  height: imageSize,
                                  fit: BoxFit.cover,
                                  imageUrl: recipe.imageUrl,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.black26,
                                    highlightColor: Colors.black12,
                                    child: Container(
                                      color: ThemeColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.name,
                                      style: TextStyles.title,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('${Points.recipePoints} points',
                                        style: TextStyles.points)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
