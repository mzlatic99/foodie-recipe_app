import '../domain/app_user.dart';
import '../domain/chat_message.dart';

abstract class ChatRepository {
  Stream<List<AppUser>> getUsers();

  Stream<List<ChatMessage>> getChatMessages(String roomId);

  Future<void> sendMessage(
      String message, String sentBy, String type, String roomId);
}
