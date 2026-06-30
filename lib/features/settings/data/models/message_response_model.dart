import 'package:rest_flow/features/inventory/domain/entities/message_response_entity.dart';

class MessageResponseModel extends MessageResponseEntity {
  const MessageResponseModel({required super.message});

  factory MessageResponseModel.fromEntity(MessageResponseEntity entity) {
    return MessageResponseModel(message: entity.message);
  }

  MessageResponseEntity toEntity() {
    return MessageResponseEntity(message: message);
  }

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(message: (json['message'] ?? '').toString());
  }

  Map<String, dynamic> toJson() => {'message': message};
}
