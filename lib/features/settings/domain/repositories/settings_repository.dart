import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/notification_settings_entity.dart';

abstract class SettingsRepository {
  /// Fetches the current user's notification settings from the backend.
  Future<Either<AppFailure, NotificationSettingsEntity>>
  fetchNotificationSettings();

  /// Partially updates the user's notification settings.
  /// Only fields with non-null values will be sent to the backend.
  Future<Either<AppFailure, void>> updateNotificationSettings(
    NotificationSettingsEntity settings,
  );
}
