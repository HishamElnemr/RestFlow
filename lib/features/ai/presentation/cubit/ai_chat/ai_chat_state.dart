import 'package:equatable/equatable.dart';

import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/features/ai/domain/entities/chat_message_response_entity.dart';

abstract class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object?> get props => [];
}

class AiChatInitial extends AiChatState {
  const AiChatInitial();
}

class AiChatLoading extends AiChatState {
  const AiChatLoading();
}

class AiChatSuccess extends AiChatState {
  final ChatMessageResponseEntity response;

  const AiChatSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AiChatError extends AiChatState {
  final AppFailure failure;

  const AiChatError(this.failure);

  @override
  List<Object?> get props => [failure];
}
