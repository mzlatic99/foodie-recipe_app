import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../theme/theme.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.asset,
    required this.onPressed,
  });
  final String asset;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: ThemeColors.white,
      ),
      onPressed: onPressed,
      icon: SvgPicture.asset(asset),
    );
  }
}
