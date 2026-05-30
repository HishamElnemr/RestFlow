import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  const AuthResponseEntity({
    required this.isSuccess,
    this.message,
    this.token,
    this.refreshToken,
    this.expiresAt,
    this.errors,
  });

  final bool isSuccess;
  final String? message;
  final String? token;
  final String? refreshToken;
  final DateTime? expiresAt;
  final List<String>? errors;

  @override
  List<Object?> get props => [
    isSuccess,
    message,
    token,
    refreshToken,
    expiresAt,
    errors ?? const [],
  ];
}
