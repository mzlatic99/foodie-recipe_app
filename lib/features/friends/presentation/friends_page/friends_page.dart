import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:foodie/features/friends/presentation/friends_page/widgets/friend_card.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:intl/intl.dart';

import '../../../../constants/string_constants.dart';
import '../../../../theme/theme.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.friends,
            style: TextStyles.title,
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => context.pushAddFriendPage(),
                child: SvgPicture.asset(
                  Assets.icons.addFriend,
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: firestore.collection('Rooms').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List data = !snapshot.hasData
                  ? []
                  : snapshot.data!.docs
                      .where((element) => element['users']
                          .toString()
                          .contains(FirebaseAuth.instance.currentUser!.uid))
                      .toList();
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  List users = data[i]['users'];
                  var friend = users.where((element) =>
                      element != FirebaseAuth.instance.currentUser!.uid);
                  var user = friend.isNotEmpty
                      ? friend.first
                      : users
                          .where((element) =>
                              element == FirebaseAuth.instance.currentUser!.uid)
                          .first;
                  return FutureBuilder(
                      future: firestore.collection('Users').doc(user).get(),
                      builder: (context, AsyncSnapshot snap) {
                        return !snap.hasData
                            ? Container()
                            : FriendCard(
                                title: snap.data['name'],
                                subtitle: data[i]['last_message'],
                                time: DateFormat.Hm().format(
                                    data[i]['last_message_time'].toDate()),
                                onTap: () => context.pushChatPage(
                                      id: user,
                                      name: snap.data['name'],
                                    ),
                                avatar: snap.data['avatar']);
                      });
                },
              );
            }),
      ),
    );
  }
}
