import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/logo_upload_response_entity.dart';
import '../../../domain/entities/restaurant_settings_entity.dart';

enum RestaurantSettingsAction { fetch, update, uploadLogo }

abstract class RestaurantSettingsState extends Equatable {
  const RestaurantSettingsState();

  @override
  List<Object?> get props => [];
}

class RestaurantSettingsInitial extends RestaurantSettingsState {
  const RestaurantSettingsInitial();
}

class RestaurantSettingsLoading extends RestaurantSettingsState {
  const RestaurantSettingsLoading(this.action);

  final RestaurantSettingsAction action;

  @override
  List<Object?> get props => [action];
}

class RestaurantSettingsLoaded extends RestaurantSettingsState {
  const RestaurantSettingsLoaded(this.settings);

  final RestaurantSettingsEntity settings;

  @override
  List<Object?> get props => [settings];
}

class RestaurantSettingsUpdateSuccess extends RestaurantSettingsState {
  const RestaurantSettingsUpdateSuccess();
}

class RestaurantSettingsLogoUploadSuccess extends RestaurantSettingsState {
  const RestaurantSettingsLogoUploadSuccess(this.response);

  final LogoUploadResponseEntity response;

  @override
  List<Object?> get props => [response];
}

class RestaurantSettingsFailure extends RestaurantSettingsState {
  const RestaurantSettingsFailure(this.failure, this.action);

  final AppFailure failure;
  final RestaurantSettingsAction action;

  @override
  List<Object?> get props => [failure, action];
}
