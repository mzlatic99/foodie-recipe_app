import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';

import '../../../../theme/theme.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Prijatelji'.hardcoded,
            style: TextStyles.title,
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  Assets.icons.addFriend,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
