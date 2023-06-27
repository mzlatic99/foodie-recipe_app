import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_colors.dart';

class TextStyles {
  static TextStyle nunito = GoogleFonts.nunito();

  static TextStyle homePageMessage = nunito.copyWith(
      fontSize: 18, color: ThemeColors.primary, fontWeight: FontWeight.bold);

  static TextStyle recipeName = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle points = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.primary,
  );

  static TextStyle time = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.white,
  );

  static TextStyle title = nunito.copyWith(
    fontSize: 16,
    color: ThemeColors.main,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subtitle = nunito.copyWith(
    fontSize: 14,
    color: ThemeColors.main,
  );

  static TextStyle text = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.greyText,
  );

  static TextStyle subtitleWhite = nunito.copyWith(
    fontSize: 14,
    color: ThemeColors.white,
  );

  static TextStyle commentName = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.primary,
  );

  static TextStyle mainText = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.main,
  );

  static TextStyle mainButton = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle selectedBottomNavLabel = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle unselectedBottomNavLabel = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.main,
  );

  static TextStyle ingredientName = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.main,
    fontWeight: FontWeight.bold,
  );

  static TextStyle onboardingTitle = nunito.copyWith(
    fontSize: 20,
    color: ThemeColors.greyText,
  );

  static TextStyle secondaryAuthText = nunito.copyWith(
    fontSize: 12,
    color: ThemeColors.main,
    fontWeight: FontWeight.bold,
  );
}
