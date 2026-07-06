import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/notification/data/models/notification_list_response_model.dart';
import '../constants/api_constants.dart';

part 'notifications_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String baseUrl}) =
      _NotificationsApiService;

  @GET('/api/Notifications')
  Future<NotificationListResponseModel> fetchNotifications();

  @PATCH('/api/Notifications/{id}/read')
  Future<void> markAsRead(@Path('id') String id);

  @POST('/api/Notifications/mark-all-read')
  Future<void> markAllAsRead();

  @POST('/api/Notifications/tokens')
  Future<void> registerDeviceToken(@Body() Map<String, dynamic> body);
}
