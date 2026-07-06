class ChatMessageRequestModel {
  final String message;

  const ChatMessageRequestModel({
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
