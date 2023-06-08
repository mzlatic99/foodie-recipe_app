import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: isActive
            ? ThemeColors.primary
            : ThemeColors.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
