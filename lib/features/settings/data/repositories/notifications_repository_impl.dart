import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/notifications_api_service.dart';
import '../../domain/entities/notification_list_response_entity.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsApiService _apiService;

  NotificationsRepositoryImpl(this._apiService);

  @override
  Future<Either<AppFailure, NotificationListResponseEntity>>
      fetchNotifications() async {
    try {
      final response = await _apiService.fetchNotifications();
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> markAsRead(String id) async {
    try {
      await _apiService.markAsRead(id);
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> markAllAsRead() async {
    try {
      await _apiService.markAllAsRead();
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, void>> registerDeviceToken(String token, int deviceType) async {
    try {
      final body = {
        'token': token,
        'deviceType': deviceType,
      };
      await _apiService.registerDeviceToken(body);
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
