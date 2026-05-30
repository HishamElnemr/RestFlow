import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/auth_response_entity.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess(this.response);

  final AuthResponseEntity response;

  @override
  List<Object?> get props => [response];
}

class RegisterFailure extends RegisterState {
  const RegisterFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
