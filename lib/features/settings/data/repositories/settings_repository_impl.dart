import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/settings_api_service.dart';
import '../../domain/entities/notification_settings_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/update_profile_request_entity.dart';
import '../../domain/entities/restaurant_settings_entity.dart';
import '../../domain/entities/update_restaurant_settings_request_entity.dart';
import '../../domain/entities/image_upload_response_entity.dart';
import '../../domain/entities/logo_upload_response_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/notification_settings_model.dart';
import '../models/user_profile_model.dart';
import '../models/update_profile_request_model.dart';
import '../models/restaurant_settings_model.dart';
import '../models/update_restaurant_settings_request_model.dart';
import '../models/image_upload_response_model.dart';
import '../models/logo_upload_response_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({SettingsApiService? apiService})
    : _apiService = apiService ?? SettingsApiService(Dio());

  final SettingsApiService _apiService;

  @override
  Future<Either<AppFailure, NotificationSettingsEntity>>
  fetchNotificationSettings() async {
    try {
      final response = await _apiService.fetchNotificationSettings();
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateNotificationSettings(
    NotificationSettingsEntity settings,
  ) async {
    try {
      await _apiService.updateNotificationSettings(
        NotificationSettingsModel.fromEntity(settings),
      );
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, UserProfileEntity>> fetchUserProfile() async {
    try {
      final UserProfileModel response = await _apiService.fetchUserProfile();
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateUserProfile(
    UpdateProfileRequestEntity request,
  ) async {
    try {
      await _apiService.updateUserProfile(
        UpdateProfileRequestModel.fromEntity(request),
      );
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, ImageUploadResponseEntity>> uploadProfileImage(
    MultipartFile file,
  ) async {
    try {
      final ImageUploadResponseModel response = await _apiService.uploadProfileImage(file);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, RestaurantSettingsEntity>>
  fetchRestaurantSettings() async {
    try {
      final RestaurantSettingsModel response = await _apiService.fetchRestaurantSettings();
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateRestaurantSettings(
    UpdateRestaurantSettingsRequestEntity request,
  ) async {
    try {
      await _apiService.updateRestaurantSettings(
        UpdateRestaurantSettingsRequestModel.fromEntity(request),
      );
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, LogoUploadResponseEntity>> uploadRestaurantLogo(
    MultipartFile file,
  ) async {
    try {
      final LogoUploadResponseModel response = await _apiService.uploadRestaurantLogo(file);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}

