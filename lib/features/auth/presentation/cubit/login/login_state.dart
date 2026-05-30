import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/auth_response_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.response);

  final AuthResponseEntity response;

  @override
  List<Object?> get props => [response];
}

class LoginFailure extends LoginState {
  const LoginFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
