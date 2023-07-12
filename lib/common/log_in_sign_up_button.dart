import 'package:flutter/material.dart';

import '../theme/theme.dart';

class LogInSignUpButton extends StatelessWidget {
  const LogInSignUpButton({
    super.key,
    required this.color,
    required this.label,
    required this.onPressed,
  });

  final Color color;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyles.mainButton,
        ),
      ),
    );
  }
}
