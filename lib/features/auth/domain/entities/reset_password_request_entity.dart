import 'package:equatable/equatable.dart';

class ResetPasswordRequestEntity extends Equatable {
  const ResetPasswordRequestEntity({
    required this.identifier,
    required this.otpCode,
    required this.newPassword,
  });

  final String identifier;
  final String otpCode;
  final String newPassword;

  @override
  List<Object?> get props => [identifier, otpCode, newPassword];
}
