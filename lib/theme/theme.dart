import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const Color primary = Color(0xffFF4A4A);
  static const Color main = Color(0xff2F2E41);
  static const Color white = Color(0xffffffff);
  static const Color greyText = Color(0xff696969);
}

class TextTheme {
  static TextStyle nunito = GoogleFonts.nunito();
  
  static TextStyle recipeNameText = nunito.copyWith(
    fontSize: 10,
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );
}