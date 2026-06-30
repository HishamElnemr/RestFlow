import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

/// Emitted when the password has been successfully changed.
class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
}

class ChangePasswordFailure extends ChangePasswordState {
  const ChangePasswordFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
