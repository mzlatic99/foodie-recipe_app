import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.label,
    required this.style,
    required this.onPressed,
  });

  final String label;
  final TextStyle style;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(
        label,
        style: style,
      ),
    );
  }
}
