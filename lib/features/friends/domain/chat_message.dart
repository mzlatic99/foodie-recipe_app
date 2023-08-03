class ChatMessage {
  final String message;
  final String sentBy;
  final DateTime datetime;
  final String type;

  ChatMessage({
    required this.message,
    required this.sentBy,
    required this.datetime,
    required this.type,
  });
}
