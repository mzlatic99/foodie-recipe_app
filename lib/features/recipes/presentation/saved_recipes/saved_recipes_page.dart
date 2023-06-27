import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';
import 'package:foodie/providers/providers.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../theme/theme.dart';
import '../../domain/recipe.dart';

class SavedRecipesPage extends ConsumerWidget {
  SavedRecipesPage({super.key});
  final box = Hive.box('favorite_recipes');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedRecipes = ref.watch(storageServiceProvider);
    final imageSize = MediaQuery.of(context).size.width * 0.35;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Spremljeni recepti'.hardcoded,
            style: TextStyles.title,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: savedRecipes.getLength(),
                    itemBuilder: (context, index) {
                      final recipe = savedRecipes.getAll()[index];
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
                                    Text('15 bodova'.hardcoded,
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
