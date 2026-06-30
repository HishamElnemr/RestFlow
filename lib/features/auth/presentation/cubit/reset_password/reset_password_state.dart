import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

/// Emitted when the password has been successfully reset.
class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPasswordFailure extends ResetPasswordState {
  const ResetPasswordFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
