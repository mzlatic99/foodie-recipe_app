import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/router/app_router.dart';

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
  int _selectedIndex = 0;

  void _tap(int index) {
    ref.invalidate(ingredientMultiplierProvider);
    ref.invalidate(instructionsCounterProvider);
    final goRouter = ref.read(goRouterProvider);
    if (index == 0) {
      goRouter.pushNamed(AppRoute.home.name);
    } else if (index == 1) {
      goRouter.pushNamed(AppRoute.challenges.name);
    } else if (index == 2) {
      goRouter.pushNamed(AppRoute.saved.name);
    } else if (index == 3) {
      goRouter.pushNamed(AppRoute.friends.name);
    } else {
      goRouter.pushNamed(AppRoute.profile.name);
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        unselectedItemColor: ThemeColors.main,
        selectedItemColor: ThemeColors.primary,
        currentIndex: _selectedIndex,
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
