import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/utils/widgets/add_space.dart';

import '../../../../../theme/theme.dart';

class DuelOptionWidget extends StatelessWidget {
  const DuelOptionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.subtitle,
        ),
        addVerticalSpace(15),
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(
            icon,
          ),
        )
      ],
    );
  }
}
