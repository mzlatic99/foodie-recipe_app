import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget(
      {super.key, required this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ThemeColors.primary, width: 1),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            children: [
              SvgPicture.asset(Assets.icons.search),
              const SizedBox(
                width: 10,
              ),
              Text(label, style: TextStyles.text),
            ],
          ),
        ),
      ),
    );
  }
}
