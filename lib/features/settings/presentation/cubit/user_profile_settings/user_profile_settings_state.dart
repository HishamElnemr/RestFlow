import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/image_upload_response_entity.dart';
import '../../../domain/entities/user_profile_entity.dart';

enum UserProfileSettingsAction { fetch, update, uploadImage }

abstract class UserProfileSettingsState extends Equatable {
  const UserProfileSettingsState();

  @override
  List<Object?> get props => [];
}

class UserProfileSettingsInitial extends UserProfileSettingsState {
  const UserProfileSettingsInitial();
}

class UserProfileSettingsLoading extends UserProfileSettingsState {
  const UserProfileSettingsLoading(this.action);

  final UserProfileSettingsAction action;

  @override
  List<Object?> get props => [action];
}

class UserProfileSettingsLoaded extends UserProfileSettingsState {
  const UserProfileSettingsLoaded(this.profile);

  final UserProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}

class UserProfileSettingsUpdateSuccess extends UserProfileSettingsState {
  const UserProfileSettingsUpdateSuccess();
}

class UserProfileSettingsImageUploadSuccess extends UserProfileSettingsState {
  const UserProfileSettingsImageUploadSuccess(this.response);

  final ImageUploadResponseEntity response;

  @override
  List<Object?> get props => [response];
}

class UserProfileSettingsFailure extends UserProfileSettingsState {
  const UserProfileSettingsFailure(this.failure, this.action);

  final AppFailure failure;
  final UserProfileSettingsAction action;

  @override
  List<Object?> get props => [failure, action];
}
