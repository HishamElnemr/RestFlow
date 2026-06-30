import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/user_profile_result_entity.dart';

abstract class AuthSessionState extends Equatable {
  const AuthSessionState();

  @override
  List<Object?> get props => [];
}

class AuthSessionInitial extends AuthSessionState {
  const AuthSessionInitial();
}

class AuthSessionLoading extends AuthSessionState {
  const AuthSessionLoading();
}

/// Emitted when [getMe] returns the current user profile.
class AuthSessionGetMeSuccess extends AuthSessionState {
  const AuthSessionGetMeSuccess(this.user);

  final UserProfileResultEntity user;

  @override
  List<Object?> get props => [user];
}

/// Emitted when [logout] completes — tokens cleared locally and on server.
class AuthSessionLogoutSuccess extends AuthSessionState {
  const AuthSessionLogoutSuccess();
}

class AuthSessionFailure extends AuthSessionState {
  const AuthSessionFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
