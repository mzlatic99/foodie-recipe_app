import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class SubtitleHorizontalLine extends StatelessWidget {
  const SubtitleHorizontalLine({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: ThemeColors.main,
      child: Text(
        label,
        style: TextStyles.subtitleWhite,
      ),
    );
  }
}
