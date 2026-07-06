import 'package:dartz/dartz.dart';

import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/core/errors/error_handler.dart';
import '../../../../core/services/ai_api_service.dart';
import '../models/chat_message_request_model.dart';
import '../../domain/entities/chat_message_response_entity.dart';
import '../../domain/entities/dashboard_insight_entity.dart';
import '../../domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final AiApiService _apiService;

  AiRepositoryImpl(this._apiService);

  @override
  Future<Either<AppFailure, ChatMessageResponseEntity>> sendMessage(
    String message,
  ) async {
    try {
      final response = await _apiService.sendMessage(
        ChatMessageRequestModel(message: message),
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, List<DashboardInsightEntity>>>
      getDashboardInsights() async {
    try {
      final response = await _apiService.getDashboardInsights();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
