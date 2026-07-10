import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/notification_settings_entity.dart';
import '../entities/user_profile_entity.dart';
import '../entities/update_profile_request_entity.dart';
import '../entities/restaurant_settings_entity.dart';
import '../entities/update_restaurant_settings_request_entity.dart';
import '../entities/image_upload_response_entity.dart';
import '../entities/logo_upload_response_entity.dart';

abstract class SettingsRepository {
  Future<Either<AppFailure, NotificationSettingsEntity>>
  fetchNotificationSettings();

  Future<Either<AppFailure, void>> updateNotificationSettings(
    NotificationSettingsEntity settings,
  );

  Future<Either<AppFailure, UserProfileEntity>> fetchUserProfile();

  Future<Either<AppFailure, void>> updateUserProfile(
    UpdateProfileRequestEntity request,
  );

  Future<Either<AppFailure, ImageUploadResponseEntity>> uploadProfileImage(
    MultipartFile file,
  );
  Future<Either<AppFailure, RestaurantSettingsEntity>> fetchRestaurantSettings();

  Future<Either<AppFailure, void>> updateRestaurantSettings(
    UpdateRestaurantSettingsRequestEntity request,
  );

  Future<Either<AppFailure, LogoUploadResponseEntity>> uploadRestaurantLogo(
    MultipartFile file,
  );
}

