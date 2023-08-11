import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'theme_colors.dart';

class AppThemes {
  static ThemeData primary({bool isDark = false}) => ThemeData(
        useMaterial3: true,
        primaryColor: ThemeColors.primary,
        scaffoldBackgroundColor: ThemeColors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
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
          type: BottomNavigationBarType.fixed,
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
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyles.text,
          focusColor: ThemeColors.greyText,
          contentPadding: const EdgeInsets.all(15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ThemeColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ThemeColors.main,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
