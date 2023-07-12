import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/theme/text_styles.dart';

class ProfileTitleRow extends StatelessWidget {
  const ProfileTitleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.function,
    required this.secondLabel,
  });

  final String icon;
  final String label;
  final void Function()? function;
  final String secondLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyles.titleProfile,
          ),
        ),
        secondLabel == ''
            ? const SizedBox.shrink()
            : TextButton(
                onPressed: function,
                child: Text(secondLabel, style: TextStyles.seeMoreButtonText))
      ],
    );
  }
}
