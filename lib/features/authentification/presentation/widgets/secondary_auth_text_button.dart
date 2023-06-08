import 'package:flutter/material.dart';
import '../../../../localization/string_hardcoded_extension.dart';

import '../../../../theme/theme.dart';

class SecondaryAuthTextButton extends StatelessWidget {
  const SecondaryAuthTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final void Function() onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
        ),
        child: Text(
          label.hardcoded,
          style: TextStyles.secondaryAuthText,
        ),
      ),
    );
  }
}
