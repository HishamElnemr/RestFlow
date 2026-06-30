import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/settings/data/models/notification_settings_model.dart';
import '../../features/settings/data/models/message_response_model.dart';
import '../constants/api_constants.dart';

part 'settings_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SettingsApiService {
  factory SettingsApiService(Dio dio, {String baseUrl}) = _SettingsApiService;

  @GET('/api/Settings/notifications')
  Future<NotificationSettingsModel> fetchNotificationSettings();

  @PATCH('/api/Settings/notifications')
  Future<MessageResponseModel> updateNotificationSettings(
    @Body() NotificationSettingsModel request,
  );
}
