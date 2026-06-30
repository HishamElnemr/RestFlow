import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

/// Emitted when the API accepts the request and sends the OTP.
class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
}

class ForgotPasswordFailure extends ForgotPasswordState {
  const ForgotPasswordFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
