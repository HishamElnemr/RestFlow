import 'package:equatable/equatable.dart';

class LogoutRequestEntity extends Equatable {
  const LogoutRequestEntity({required this.refreshToken});

  final String refreshToken;

  @override
  List<Object?> get props => [refreshToken];
}
