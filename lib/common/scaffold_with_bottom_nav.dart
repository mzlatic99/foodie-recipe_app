import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/router/app_route.dart';
import 'package:foodie/router/app_router.dart';

import '../theme/theme.dart';

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends ConsumerState<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    final goRouter = ref.read(goRouterProvider);
    if (index == _selectedIndex) {
      return;
    }
    if (index == 0) {
      goRouter.pushNamed(AppRoute.home.name);
    } else if (index == 1) {
      goRouter.pushNamed(AppRoute.challanges.name);
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
        currentIndex: _selectedIndex,
        elevation: 6,
        unselectedItemColor: ThemeColors.main,
        selectedItemColor: ThemeColors.primary,
        onTap: (index) => _tap(context, index),
        items: [
          bottomNavBarItem(Assets.icons.home, 'Početna'),
          bottomNavBarItem(Assets.icons.challanges, 'Izazovi'),
          bottomNavBarItem(Assets.icons.saved, 'Spremljeni recepti'),
          bottomNavBarItem(Assets.icons.friends, 'Prijatelji'),
          bottomNavBarItem(Assets.icons.profile, 'Profil'),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(String assetName, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          assetName,
        ),
        activeIcon: SvgPicture.asset(
          assetName,
          theme: const SvgTheme(
            currentColor: ThemeColors.primary,
          ),
          colorFilter:
              const ColorFilter.mode(ThemeColors.primary, BlendMode.srcATop),
        ),
        label: label);
  }
}
