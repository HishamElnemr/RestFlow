import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/settings_api_service.dart';
import '../../domain/entities/notification_settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/notification_settings_model.dart';

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
}
