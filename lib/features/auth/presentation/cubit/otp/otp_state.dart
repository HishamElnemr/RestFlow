import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/auth_response_entity.dart';

enum OtpAction { verify, resend }

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {
  const OtpInitial();
}

class OtpLoading extends OtpState {
  const OtpLoading(this.action);

  final OtpAction action;

  @override
  List<Object?> get props => [action];
}

class OtpSuccess extends OtpState {
  const OtpSuccess(this.response, this.action);

  final AuthResponseEntity response;
  final OtpAction action;

  @override
  List<Object?> get props => [response, action];
}

class OtpFailure extends OtpState {
  const OtpFailure(this.failure, this.action);

  final AppFailure failure;
  final OtpAction action;

  @override
  List<Object?> get props => [failure, action];
}
