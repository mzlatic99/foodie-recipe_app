import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.label,
    required this.style,
    required this.onPressed,
    required this.backgorundColor,
    this.elevation = 6,
  });

  final String label;
  final TextStyle style;
  final void Function()? onPressed;
  final Color backgorundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: elevation,
      backgroundColor: backgorundColor,
      onPressed: onPressed,
      label: Text(
        label,
        style: style,
      ),
    );
  }
}
