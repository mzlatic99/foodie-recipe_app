import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/theme.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.asset,
    required this.title,
  });

  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(asset),
        const Spacer(),
        Text(
          title,
          style: TextStyles.onboardingTitle,
        ),
        title == '' ? const SizedBox.shrink() : const Spacer(),
      ],
    );
  }
}
