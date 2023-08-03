// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/common/main_button_widget.dart';
import 'package:foodie/features/friends/presentation/chat/chat_controller.dart';
import 'package:foodie/features/friends/presentation/chat/widgets/message_field.dart';
import 'package:foodie/features/friends/presentation/chat/widgets/messages_card.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';
import 'package:intl/intl.dart';

import '../../../../constants/firebase_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../theme/theme.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key, required this.id, required this.name, this.roomId})
      : super(key: key);
  final String id;
  final String name;
  final String? roomId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late String? roomId;
  @override
  Widget build(BuildContext context) {
    roomId = widget.roomId;
    final chatController = ref.watch(chatControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          widget.name,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: roomId != null
                  ? MainButtonWidget(
                      label: StringConstants.sendCulinaryDuel,
                      style: TextStyles.mainButton,
                      onPressed: () => context.pushDuelPage(
                        id: widget.id,
                        name: widget.name,
                        roomId: roomId!,
                      ),
                      backgorundColor: ThemeColors.primary,
                      elevation: 0,
                    )
                  : const SizedBox.shrink()),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: chatController.getRoomsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot?> allData = snapshot.data!.docs
                          .where((element) =>
                              element[FirebaseConstants.usersField]
                                  .contains(widget.id) &&
                              element[FirebaseConstants.usersField].contains(
                                  FirebaseAuth.instance.currentUser!.uid))
                          .toList();
                      QueryDocumentSnapshot? data =
                          allData.isNotEmpty ? allData.first : null;
                      if (data != null) {
                        roomId = data.id;
                      }
                      return data == null
                          ? Container()
                          : StreamBuilder(
                              stream: data.reference
                                  .collection(
                                      FirebaseConstants.messagesSubcollection)
                                  .orderBy(FirebaseConstants.dateTimeRoomsField,
                                      descending: true)
                                  .snapshots(),
                              builder:
                                  (context, AsyncSnapshot<QuerySnapshot> snap) {
                                return !snap.hasData
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: snap.data!.docs.length,
                                        reverse: true,
                                        itemBuilder: (context, i) {
                                          final messageType = snap.data!.docs[i]
                                              [FirebaseConstants.chatType];
                                          return MessagesCard(
                                              messageType,
                                              snap.data!.docs[i][
                                                      FirebaseConstants
                                                          .sentByField] ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                              snap.data!.docs[i][
                                                  FirebaseConstants
                                                      .messageField],
                                              DateFormat.Hm().format(snap
                                                  .data!
                                                  .docs[i][FirebaseConstants
                                                      .dateTimeRoomsField]
                                                  .toDate()));
                                        },
                                      );
                              });
                    } else {
                      return Center(
                        child: Text(
                          'No conversion found',
                          style: TextStyles.subtitle,
                        ),
                      );
                    }
                  } else {
                    return const Loader();
                  }
                }),
          ),
          Container(
            color: Colors.white,
            child: MessageField(onSubmit: (message, type) {
              chatController.sendMessage(
                message,
                type,
                roomId,
                widget.id,
              );
            }),
          )
        ],
      ),
    );
  }
}
