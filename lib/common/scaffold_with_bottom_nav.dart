import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../theme/theme.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      // Note: this won't remember the previous state of the route
      // More info here:
      // https://github.com/flutter/flutter/issues/99124
      // context.goNamed(AppRouter.);
    } else if (index == 1) {
      // context.goNamed(AppRoute.favorites.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        unselectedItemColor: ThemeColors.main,
        selectedItemColor: ThemeColors.primary,
        onTap: (index) => _tap(context, index),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home,
              ),
              label: 'Početna'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.challanges,
              ),
              label: 'Izazovi'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.saved,
              ),
              label: 'Spremljeni recepti'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.friends,
              ),
              label: 'Prijatelji'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.profile,
              ),
              label: 'Profil'),
        ],
      ),
    );
  }
}
