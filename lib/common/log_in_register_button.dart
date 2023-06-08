import 'package:flutter/material.dart';

import '../theme/theme.dart';

class LogInRegisterButton extends StatelessWidget {
  const LogInRegisterButton({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
      ),
    );
  }
}
