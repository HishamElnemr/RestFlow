import '../../domain/entities/refresh_token_request_entity.dart';

class RefreshTokenRequestModel extends RefreshTokenRequestEntity {
  const RefreshTokenRequestModel({required super.refreshToken});

  factory RefreshTokenRequestModel.fromEntity(
    RefreshTokenRequestEntity entity,
  ) {
    return RefreshTokenRequestModel(refreshToken: entity.refreshToken);
  }

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequestModel(
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
