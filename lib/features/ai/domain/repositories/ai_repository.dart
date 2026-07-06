import 'package:dartz/dartz.dart';

import 'package:rest_flow/core/errors/app_failure.dart';
import '../entities/chat_message_response_entity.dart';
import '../entities/dashboard_insight_entity.dart';

abstract class AiRepository {
  Future<Either<AppFailure, ChatMessageResponseEntity>> sendMessage(
    String message,
  );

  Future<Either<AppFailure, List<DashboardInsightEntity>>>
      getDashboardInsights();
}
