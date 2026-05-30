import 'package:equatable/equatable.dart';

class LoginRequestEntity extends Equatable {
  const LoginRequestEntity({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
