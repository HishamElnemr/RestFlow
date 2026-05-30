import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  const RegisterRequestEntity({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [
    fullName,
    email,
    phoneNumber,
    password,
    confirmPassword,
  ];
}
