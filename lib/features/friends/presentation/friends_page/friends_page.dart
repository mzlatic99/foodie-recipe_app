import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/friends/presentation/chat_page/chat_controller.dart';

import 'package:foodie/features/friends/presentation/friends_page/widgets/friend_card.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:intl/intl.dart';

import '../../../../constants/firebase_constants.dart';
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
    final chatController = ref.watch(chatControllerProvider.notifier);
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
            stream: chatController.getRoomsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List data = !snapshot.hasData
                  ? []
                  : snapshot.data!.docs
                      .where((element) => element[FirebaseConstants.usersField]
                          .toString()
                          .contains(FirebaseAuth.instance.currentUser!.uid))
                      .toList();
              return data.isEmpty
                  ? Center(
                      child: Text(
                        'No conversations found',
                        style: TextStyles.subtitle,
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        List users = data[i][FirebaseConstants.usersField];
                        var friend = users.where((element) =>
                            element != FirebaseAuth.instance.currentUser!.uid);
                        var user = friend.isNotEmpty
                            ? friend.first
                            : users
                                .where((element) =>
                                    element ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                .first;
                        return FutureBuilder(
                            future: firestore
                                .collection(FirebaseConstants.usersCollection)
                                .doc(user)
                                .get(),
                            builder: (context, AsyncSnapshot snap) {
                              String roomId = data[i].id;
                              return !snap.hasData
                                  ? Container()
                                  : FriendCard(
                                      title: snap
                                          .data[FirebaseConstants.nameField],
                                      subtitle: data[i]
                                          [FirebaseConstants.lastMessageField],
                                      time: DateFormat.Hm().format(data[i][
                                              FirebaseConstants
                                                  .lastMessageTimeField]
                                          .toDate()),
                                      onTap: () => context.pushChatPage(
                                          id: user,
                                          name: snap.data[
                                              FirebaseConstants.nameField],
                                          roomId: roomId),
                                      avatar: snap
                                          .data[FirebaseConstants.avatarField]);
                            });
                      },
                    );
            }),
      ),
    );
  }
}
