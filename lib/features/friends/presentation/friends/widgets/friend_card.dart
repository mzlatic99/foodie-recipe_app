import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../theme/theme.dart';

class FriendCard extends StatelessWidget {
  const FriendCard(
      {required this.title,
      required this.time,
      required this.subtitle,
      required this.onTap,
      required this.avatar,
      super.key});
  final String title;
  final String time;
  final String? subtitle;
  final void Function()? onTap;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SvgPicture.asset(avatar),
          ),
          title: Text(
            title,
            style: TextStyles.mainText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  maxLines: 1,
                  style: TextStyles.text,
                )
              : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              time,
              style: TextStyles.text,
            ),
          ),
        ),
      ),
    );
  }
}
