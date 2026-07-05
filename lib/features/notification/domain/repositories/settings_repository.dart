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
  /// Fetches the current user's notification settings from the backend.
  Future<Either<AppFailure, NotificationSettingsEntity>>
  fetchNotificationSettings();

  /// Partially updates the user's notification settings.
  /// Only fields with non-null values will be sent to the backend.
  Future<Either<AppFailure, void>> updateNotificationSettings(
    NotificationSettingsEntity settings,
  );

  /// Fetches the user profile details.
  Future<Either<AppFailure, UserProfileEntity>> fetchUserProfile();

  /// Updates the user profile details.
  Future<Either<AppFailure, void>> updateUserProfile(
    UpdateProfileRequestEntity request,
  );

  /// Uploads user profile image.
  Future<Either<AppFailure, ImageUploadResponseEntity>> uploadProfileImage(
    MultipartFile file,
  );

  /// Fetches the restaurant settings.
  Future<Either<AppFailure, RestaurantSettingsEntity>> fetchRestaurantSettings();

  /// Updates the restaurant settings.
  Future<Either<AppFailure, void>> updateRestaurantSettings(
    UpdateRestaurantSettingsRequestEntity request,
  );

  /// Uploads restaurant logo.
  Future<Either<AppFailure, LogoUploadResponseEntity>> uploadRestaurantLogo(
    MultipartFile file,
  );
}

