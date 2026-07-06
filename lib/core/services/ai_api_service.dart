import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/ai/data/models/chat_message_request_model.dart';
import '../../features/ai/data/models/chat_message_response_model.dart';
import '../../features/ai/data/models/dashboard_insight_model.dart';

part 'ai_api_service.g.dart';

@RestApi()
abstract class AiApiService {
  factory AiApiService(Dio dio, {String baseUrl}) = _AiApiService;

  @POST('/api/ai/chat/message')
  Future<ChatMessageResponseModel> sendMessage(
    @Body() ChatMessageRequestModel request,
  );

  @GET('/api/ai/dashboard-insights')
  Future<List<DashboardInsightModel>> getDashboardInsights();
}
