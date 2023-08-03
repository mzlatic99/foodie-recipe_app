import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/constants/firebase_constants.dart';

import '../domain/app_user.dart';
import '../domain/chat_message.dart';
import 'chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return FirebaseChatRepository();
});

class FirebaseChatRepository implements ChatRepository {
  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Stream<List<AppUser>> getUsers() {
    return firestore
        .collection(FirebaseConstants.usersCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => AppUser(uid: doc.id)).toList();
    });
  }

  @override
  Stream<List<ChatMessage>> getChatMessages(String roomId) {
    return firestore
        .collection(FirebaseConstants.roomsColection)
        .doc(roomId)
        .collection(FirebaseConstants.messagesSubcollection)
        .orderBy(FirebaseConstants.dateTimeRoomsField, descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatMessage(
          message: doc[FirebaseConstants.messageField] as String,
          sentBy: doc[FirebaseConstants.sentByField] as String,
          datetime:
              (doc[FirebaseConstants.dateTimeRoomsField] as Timestamp).toDate(),
          type: doc[FirebaseConstants.chatType.toString()],
        );
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(
      String message, String sentBy, String type, String roomId) {
    Map<String, dynamic> data = {
      FirebaseConstants.messageField: message,
      FirebaseConstants.sentByField: sentBy,
      FirebaseConstants.dateTimeRoomsField: DateTime.now(),
      FirebaseConstants.chatType: type,
    };
    return firestore
        .collection(FirebaseConstants.roomsColection)
        .doc(roomId)
        .collection(FirebaseConstants.messagesSubcollection)
        .add(data);
  }
}
