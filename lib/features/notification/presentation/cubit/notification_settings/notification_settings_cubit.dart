import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/notification_settings_entity.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'notification_settings_state.dart';

class NotificationSettingsCubit
    extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit(this._settingsRepository)
      : super(const NotificationSettingsInitial());

  final SettingsRepository _settingsRepository;

  /// Fetches the current notification settings from the backend and emits
  /// [NotificationSettingsLoaded] on success or [NotificationSettingsFailure]
  /// on error.
  Future<void> fetchNotificationSettings() async {
    emit(const NotificationSettingsLoading());
    final result = await _settingsRepository.fetchNotificationSettings();
    result.fold(
      (failure) => emit(NotificationSettingsFailure(failure)),
      (settings) => emit(NotificationSettingsLoaded(settings)),
    );
  }

  /// Sends a PATCH request to update one or more notification preference
  /// fields.  Only the fields provided as non-null will be sent.  Emits
  /// [NotificationSettingsUpdating] while the request is in-flight, then
  /// either [NotificationSettingsUpdateSuccess] or
  /// [NotificationSettingsFailure].
  Future<void> updateNotificationSettings(
    NotificationSettingsEntity settings,
  ) async {
    // Preserve the current settings in the updating state so the UI can
    // still render the existing values while the request runs.
    final currentSettings = state is NotificationSettingsLoaded
        ? (state as NotificationSettingsLoaded).settings
        : state is NotificationSettingsUpdateSuccess
            ? (state as NotificationSettingsUpdateSuccess).settings
            : settings;

    emit(NotificationSettingsUpdating(currentSettings));

    final result = await _settingsRepository.updateNotificationSettings(
      settings,
    );
    result.fold(
      (failure) => emit(NotificationSettingsFailure(failure)),
      (_) => emit(NotificationSettingsUpdateSuccess(settings)),
    );
  }

  /// Convenience helper that toggles a single boolean field by fetching the
  /// current loaded settings and sending an update with only that field set.
  Future<void> toggleEmailNotifications({required bool value}) async {
    await updateNotificationSettings(
      NotificationSettingsEntity(emailNotifications: value),
    );
  }

  Future<void> toggleInAppNotifications({required bool value}) async {
    await updateNotificationSettings(
      NotificationSettingsEntity(inAppNotifications: value),
    );
  }

  Future<void> toggleAiInsightsNotifications({required bool value}) async {
    await updateNotificationSettings(
      NotificationSettingsEntity(aiInsightsNotifications: value),
    );
  }

  Future<void> toggleInventoryAlerts({required bool value}) async {
    await updateNotificationSettings(
      NotificationSettingsEntity(inventoryAlerts: value),
    );
  }

  Future<void> toggleImportantAlerts({required bool value}) async {
    await updateNotificationSettings(
      NotificationSettingsEntity(importantAlerts: value),
    );
  }

  void reset() {
    emit(const NotificationSettingsInitial());
  }
}
