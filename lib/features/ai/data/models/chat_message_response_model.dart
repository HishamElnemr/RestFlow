import '../../domain/entities/chat_message_response_entity.dart';

class ChatMessageResponseModel extends ChatMessageResponseEntity {
  const ChatMessageResponseModel({
    required super.success,
    required super.response,
    required super.generatedAt,
  });

  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponseModel(
      success: json['success'] as bool? ?? false,
      response: json['response'] as String? ?? '',
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'] as String).toLocal()
          : DateTime.now(),
    );
  }
}
