import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/constants/app_constants.dart';
import 'package:foodie/router/scaffold_with_bottom_nav_controller.dart';
import 'package:go_router/go_router.dart';

import '../constants/string_constants.dart';
import '../features/recipes/presentation/recipe_controller.dart';
import '../providers/providers.dart';
import '../theme/theme.dart';
import 'app_route.dart';

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  ConsumerState<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends ConsumerState<ScaffoldWithBottomNavBar> {
  void _tap(int index) {
    ref.read(scaffoldBottomNavControllerProvider.notifier).setPosition(index);
    ref.invalidate(ingredientMultiplierProvider);
    ref.invalidate(instructionsCounterProvider);
    if (index == 0) {
      context.goNamed(AppRoute.home.name);
      ref.read(recipeControllerProvider.notifier).ref.invalidateSelf();
    } else if (index == 1) {
      context.goNamed(AppRoute.challenges.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.saved.name);
    } else if (index == 3) {
      context.goNamed(AppRoute.friends.name);
    } else {
      context.goNamed(AppRoute.profile.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    int position = ref.watch(scaffoldBottomNavControllerProvider);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: position,
        onTap: (index) => _tap(index),
        items: [
          _buildBottomNavBarItemWidget(Assets.icons.home, StringConstants.home),
          _buildBottomNavBarItemWidget(
              Assets.icons.challenges, StringConstants.challenges),
          _buildBottomNavBarItemWidget(
              Assets.icons.saved, StringConstants.saved),
          _buildBottomNavBarItemWidget(
              Assets.icons.friends, StringConstants.friends),
          _buildBottomNavBarItemWidget(
              Assets.icons.profile, StringConstants.profile),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItemWidget(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          iconName,
          height: AppConstants.bottomNavbarIconHeight,
        ),
        activeIcon: SvgPicture.asset(
          iconName,
          height: AppConstants.bottomNavbarIconHeight,
          theme: const SvgTheme(
            currentColor: ThemeColors.primary,
          ),
          colorFilter:
              const ColorFilter.mode(ThemeColors.primary, BlendMode.srcATop),
        ),
        label: label);
  }
}
