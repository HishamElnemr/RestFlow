class ChatMessageResponseEntity {
  final bool success;
  final String response;
  final DateTime generatedAt;

  const ChatMessageResponseEntity({
    required this.success,
    required this.response,
    required this.generatedAt,
  });
}
