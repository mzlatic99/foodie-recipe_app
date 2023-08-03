import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/firebase_constants.dart';
import '../domain/culinary_duel.dart';

final culinaryDuelRepositoryProvider = Provider<DuelRepository>(
  (ref) => DuelRepository(),
);

class DuelRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> sendCulinaryDuel(
      CulinaryDuel culinaryDuel, String roomId) async {
    Map<String, dynamic> data = {
      FirebaseConstants.messageField: culinaryDuel.recipe!.id,
      FirebaseConstants.sentByField: culinaryDuel.senderUserId,
      FirebaseConstants.dateTimeRoomsField: DateTime.now(),
    };
    await firestore
        .collection(FirebaseConstants.roomsColection)
        .doc(roomId)
        .collection(FirebaseConstants.messagesSubcollection)
        .add(data);
  }

  Future<void> acceptCulinaryDuel(CulinaryDuel culinaryDuel) async {
    // Implement the logic for accepting the culinary duel here
    // For example, you can update the status of the culinary duel in the database or API
    // Make sure to handle any errors that may occur during the process
  }

  Future<void> declineCulinaryDuel(CulinaryDuel culinaryDuel) async {
    // Implement the logic for declining the culinary duel here
    // For example, you can update the status of the culinary duel in the database or API
    // Make sure to handle any errors that may occur during the process
  }
}
