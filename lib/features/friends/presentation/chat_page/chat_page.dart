// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/common/main_button_widget.dart';
import 'package:foodie/features/friends/presentation/chat_page/widgets/message_field.dart';
import 'package:foodie/features/friends/presentation/chat_page/widgets/messages_card.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';
import 'package:intl/intl.dart';

import '../../../../constants/string_constants.dart';
import '../../../../theme/theme.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key, required this.id, required this.name})
      : super(key: key);
  final String id;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  var roomId;
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          widget.name,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: MainButtonWidget(
              label: StringConstants.sendCulinaryDuel,
              style: TextStyles.mainButton,
              onPressed: () {},
              backgorundColor: ThemeColors.primary,
              elevation: 0,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: firestore
                        .collection('Users')
                        .doc(widget.id)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : Text(
                              'Last seen : ${DateFormat.Hm().format(snapshot.data!['date_time'].toDate())}',
                              style: TextStyles.text);
                    }),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: firestore.collection('Rooms').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot?> allData = snapshot.data!.docs
                          .where((element) =>
                              element['users'].contains(widget.id) &&
                              element['users'].contains(
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
                                  .collection('messages')
                                  .orderBy('datetime', descending: true)
                                  .snapshots(),
                              builder:
                                  (context, AsyncSnapshot<QuerySnapshot> snap) {
                                return !snap.hasData
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: snap.data!.docs.length,
                                        reverse: true,
                                        itemBuilder: (context, i) {
                                          print(
                                              'MESSAGE: ${snap.data!.docs[i]['message'].runtimeType}');
                                          final bool isImage = snap
                                              .data!.docs[i]['message']
                                              .toString()
                                              .startsWith('URL');
                                          return MessagesCard(
                                              isImage ? 'image' : 'text',
                                              snap.data!.docs[i]['sent_by'] ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                              snap.data!.docs[i]['message'],
                                              DateFormat.Hm().format(snap
                                                  .data!.docs[i]['datetime']
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
              if (type == 'image') {
                if (roomId != null) {
                  Map<String, dynamic> data = {
                    'message': message,
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').doc(roomId).update({
                    'last_message_time': DateTime.now(),
                    'last_message': message,
                  });
                  firestore
                      .collection('Rooms')
                      .doc(roomId)
                      .collection('messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': message,
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').add({
                    'users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid,
                    ],
                    'last_message': message,
                    'last_message_time': DateTime.now(),
                  }).then((value) async {
                    value.collection('messages').add(data);
                  });
                }
              } else if (message.isNotEmpty) {
                if (roomId != null) {
                  Map<String, dynamic> data = {
                    'message': message.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').doc(roomId).update({
                    'last_message_time': DateTime.now(),
                    'last_message': message,
                  });
                  firestore
                      .collection('Rooms')
                      .doc(roomId)
                      .collection('messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': message.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').add({
                    'users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid,
                    ],
                    'last_message': message,
                    'last_message_time': DateTime.now(),
                  }).then((value) async {
                    value.collection('messages').add(data);
                  });
                }
              }
            }),
          )
        ],
      ),
    );
  }
}
