import 'package:equatable/equatable.dart';

class RefreshTokenRequestEntity extends Equatable {
  const RefreshTokenRequestEntity({required this.refreshToken});

  final String refreshToken;

  @override
  List<Object?> get props => [refreshToken];
}
