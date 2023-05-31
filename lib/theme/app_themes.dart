import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'theme_colors.dart';

class AppThemes {
  static ThemeData primary({bool isDark = false}) => ThemeData(
        useMaterial3: true,
        primaryColor: ThemeColors.primary,
        scaffoldBackgroundColor: ThemeColors.white,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: ThemeColors.white,
        ),
        cardColor: ThemeColors.main,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ThemeColors.primary,
            extendedSizeConstraints:
                BoxConstraints(minWidth: 100, minHeight: 50)),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyles.title.copyWith(
            color: ThemeColors.main,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.white,
          elevation: 6,
          selectedItemColor: ThemeColors.primary,
          unselectedItemColor: ThemeColors.main,
          selectedLabelStyle: TextStyles.selectedBottomNavLabel,
          unselectedLabelStyle: TextStyles.unselectedBottomNavLabel,
          selectedIconTheme: const IconThemeData(
            color: ThemeColors.primary,
          ),
          unselectedIconTheme: const IconThemeData(
            color: ThemeColors.main,
          ),
        ),
      );
}
