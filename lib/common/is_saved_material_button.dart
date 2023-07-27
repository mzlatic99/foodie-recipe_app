import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/constants/app_constants.dart';

import '../features/recipes/domain/recipe.dart';
import '../providers/providers.dart';
import '../theme/theme.dart';

class IsSavedMaterialButton extends ConsumerStatefulWidget {
  const IsSavedMaterialButton({required this.recipe, super.key});
  final Recipe recipe;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IsSavedMaterialButtonState();
}

class _IsSavedMaterialButtonState extends ConsumerState<IsSavedMaterialButton> {
  @override
  Widget build(BuildContext context) {
    final storageService = ref.watch(storageServiceProvider);
    final isSaved = storageService.hasValue<Recipe>(
        widget.recipe.id.toString(), StorageBox.favoritesBox);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSaved
              ? ref.watch(storageServiceProvider).deleteValue<Recipe>(
                  widget.recipe.id.toString(), StorageBox.favoritesBox)
              : ref.watch(storageServiceProvider).setValue<Recipe>(
                  widget.recipe.id.toString(),
                  widget.recipe,
                  StorageBox.favoritesBox);
        });
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          elevation: 0,
          color: ThemeColors.white,
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: SvgPicture.asset(
              isSaved ? Assets.icons.saved : Assets.icons.save,
              height: 18,
              colorFilter:
                  const ColorFilter.mode(ThemeColors.primary, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
