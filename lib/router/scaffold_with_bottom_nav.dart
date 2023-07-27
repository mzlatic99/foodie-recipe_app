import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/router/scaffold_with_bottom_nav_controller.dart';
import 'package:go_router/go_router.dart';

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
        elevation: 6,
        unselectedItemColor: ThemeColors.main,
        selectedItemColor: ThemeColors.primary,
        currentIndex: position,
        onTap: (index) => _tap(index),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.home,
                theme: const SvgTheme(
                  currentColor: ThemeColors.primary,
                ),
                colorFilter: const ColorFilter.mode(
                    ThemeColors.primary, BlendMode.srcATop),
              ),
              label: 'Početna'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.challenges,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.challenges,
                theme: const SvgTheme(
                  currentColor: ThemeColors.primary,
                ),
                colorFilter: const ColorFilter.mode(
                    ThemeColors.primary, BlendMode.srcATop),
              ),
              label: 'Izazovi'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.saved,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.saved,
                theme: const SvgTheme(
                  currentColor: ThemeColors.primary,
                ),
                colorFilter: const ColorFilter.mode(
                    ThemeColors.primary, BlendMode.srcATop),
              ),
              label: 'Spremljeni recepti'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.friends,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.friends,
                theme: const SvgTheme(
                  currentColor: ThemeColors.primary,
                ),
                colorFilter: const ColorFilter.mode(
                    ThemeColors.primary, BlendMode.srcATop),
              ),
              label: 'Prijatelji'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.profile,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.profile,
                theme: const SvgTheme(
                  currentColor: ThemeColors.primary,
                ),
                colorFilter: const ColorFilter.mode(
                    ThemeColors.primary, BlendMode.srcATop),
              ),
              label: 'Profil'),
        ],
      ),
    );
  }
}
