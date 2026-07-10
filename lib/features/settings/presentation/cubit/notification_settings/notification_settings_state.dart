import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/notification_settings_entity.dart';

abstract class NotificationSettingsState extends Equatable {
  const NotificationSettingsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data has been fetched.
class NotificationSettingsInitial extends NotificationSettingsState {
  const NotificationSettingsInitial();
}

/// Emitted while fetching notification settings from the API.
class NotificationSettingsLoading extends NotificationSettingsState {
  const NotificationSettingsLoading();
}

/// Emitted when settings have been successfully fetched.
class NotificationSettingsLoaded extends NotificationSettingsState {
  const NotificationSettingsLoaded(this.settings);

  final NotificationSettingsEntity settings;

  @override
  List<Object?> get props => [settings];
}

/// Emitted when fetching or updating settings fails.
class NotificationSettingsFailure extends NotificationSettingsState {
  const NotificationSettingsFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

/// Emitted while an update PATCH request is in flight.
/// Carries the existing settings so the UI remains responsive.
class NotificationSettingsUpdating extends NotificationSettingsState {
  const NotificationSettingsUpdating(this.currentSettings);

  final NotificationSettingsEntity currentSettings;

  @override
  List<Object?> get props => [currentSettings];
}

/// Emitted when a settings update has completed successfully.
class NotificationSettingsUpdateSuccess extends NotificationSettingsState {
  const NotificationSettingsUpdateSuccess(this.settings);

  final NotificationSettingsEntity settings;

  @override
  List<Object?> get props => [settings];
}
