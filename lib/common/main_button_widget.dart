import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.label,
    required this.style,
    required this.onPressed,
    required this.backgorundColor,
  });

  final String label;
  final TextStyle style;
  final void Function() onPressed;
  final Color backgorundColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: backgorundColor,
      onPressed: onPressed,
      label: Text(
        label,
        style: style,
      ),
    );
  }
}
