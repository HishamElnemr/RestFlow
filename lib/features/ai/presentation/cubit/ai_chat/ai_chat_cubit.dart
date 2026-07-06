import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/ai/domain/repositories/ai_repository.dart';

import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiRepository _repository;

  AiChatCubit(this._repository) : super(const AiChatInitial());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    emit(const AiChatLoading());

    final result = await _repository.sendMessage(message);

    result.fold(
      (failure) => emit(AiChatError(failure)),
      (response) => emit(AiChatSuccess(response)),
    );
  }
}
