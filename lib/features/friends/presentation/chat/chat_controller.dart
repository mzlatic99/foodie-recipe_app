import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/firebase_constants.dart';

final chatControllerProvider = StateNotifierProvider.autoDispose<ChatController,
    AsyncValue<List<QueryDocumentSnapshot>>>((ref) {
  return ChatController();
});

final searchProvider = StateProvider<String>((ref) => '');

class ChatController
    extends StateNotifier<AsyncValue<List<QueryDocumentSnapshot>>> {
  ChatController() : super(const AsyncLoading());

  Stream<QuerySnapshot> getRoomsStream() {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.roomsColection)
        .snapshots();
  }

  Stream<QuerySnapshot> getUsersStream() {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.usersCollection)
        .snapshots();
  }

  Stream<List<QueryDocumentSnapshot>> getMessagesStream(String? roomId) {
    if (roomId != null) {
      return FirebaseFirestore.instance
          .collection(FirebaseConstants.roomsColection)
          .doc(roomId)
          .collection(FirebaseConstants.messagesSubcollection)
          .orderBy(FirebaseConstants.dateTimeRoomsField, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs);
    } else {
      return Stream.value([]);
    }
  }

  Future<void> sendMessage(
      String message, String type, String? roomId, String userId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final messageData = {
      FirebaseConstants.messageField: message,
      FirebaseConstants.sentByField: currentUser.uid,
      FirebaseConstants.dateTimeRoomsField: DateTime.now(),
      FirebaseConstants.chatType: type,
    };

    final roomData = {
      FirebaseConstants.usersField: [userId, currentUser.uid],
      FirebaseConstants.lastMessageField: message,
      FirebaseConstants.lastMessageTimeField: DateTime.now(),
    };

    final firestore = FirebaseFirestore.instance;
    if (roomId != null) {
      await firestore
          .collection(FirebaseConstants.roomsColection)
          .doc(roomId)
          .update({
        FirebaseConstants.lastMessageTimeField: DateTime.now(),
        FirebaseConstants.lastMessageField: message,
      });
      await firestore
          .collection(FirebaseConstants.roomsColection)
          .doc(roomId)
          .collection(FirebaseConstants.messagesSubcollection)
          .add(messageData);
    } else {
      final roomRef = await firestore
          .collection(FirebaseConstants.roomsColection)
          .add(roomData);
      await roomRef
          .collection(FirebaseConstants.messagesSubcollection)
          .add(messageData);
    }
  }
}
