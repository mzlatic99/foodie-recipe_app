import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

void showSnackBar(
  BuildContext context, {
  required String content,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content),
          backgroundColor: ThemeColors.main,
          duration: const Duration(milliseconds: 1200)),
    );
