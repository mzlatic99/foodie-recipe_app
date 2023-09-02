import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/theme/text_styles.dart';

class ProfileTitleRow extends StatelessWidget {
  const ProfileTitleRow({
    super.key,
    required this.icon,
    required this.label,
  });

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
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
        ],
      ),
    );
  }
}
