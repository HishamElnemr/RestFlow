import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/notification_list_response_entity.dart';

abstract class NotificationsRepository {
  Future<Either<AppFailure, NotificationListResponseEntity>> fetchNotifications();
  Future<Either<AppFailure, void>> markAsRead(String id);
  Future<Either<AppFailure, void>> markAllAsRead();
}
