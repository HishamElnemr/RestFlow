import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/settings/data/models/notification_settings_model.dart';
import '../../features/settings/data/models/message_response_model.dart';
import '../../features/settings/data/models/user_profile_model.dart';
import '../../features/settings/data/models/update_profile_request_model.dart';
import '../../features/settings/data/models/restaurant_settings_model.dart';
import '../../features/settings/data/models/update_restaurant_settings_request_model.dart';
import '../../features/settings/data/models/image_upload_response_model.dart';
import '../../features/settings/data/models/logo_upload_response_model.dart';
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

  @GET('/api/Settings/profile')
  Future<UserProfileModel> fetchUserProfile();

  @PATCH('/api/Settings/profile')
  Future<MessageResponseModel> updateUserProfile(
    @Body() UpdateProfileRequestModel request,
  );

  @POST('/api/Settings/profile/image')
  @MultiPart()
  Future<ImageUploadResponseModel> uploadProfileImage(
    @Part() MultipartFile file,
  );

  @GET('/api/Settings/restaurant')
  Future<RestaurantSettingsModel> fetchRestaurantSettings();

  @PATCH('/api/Settings/restaurant')
  Future<MessageResponseModel> updateRestaurantSettings(
    @Body() UpdateRestaurantSettingsRequestModel request,
  );

  @POST('/api/Settings/restaurant/logo')
  @MultiPart()
  Future<LogoUploadResponseModel> uploadRestaurantLogo(
    @Part() MultipartFile file,
  );
}

