import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          errorMessage,
          style: TextStyles.points
              .copyWith(fontSize: 25, decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
