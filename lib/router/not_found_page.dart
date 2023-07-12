import 'package:flutter/material.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';

import '../theme/text_styles.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          '404 - Page not found!'.hardcoded,
          style: TextStyles.points
              .copyWith(fontSize: 25, decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
