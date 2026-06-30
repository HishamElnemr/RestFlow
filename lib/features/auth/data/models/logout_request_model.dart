import '../../domain/entities/logout_request_entity.dart';

class LogoutRequestModel extends LogoutRequestEntity {
  const LogoutRequestModel({required super.refreshToken});

  factory LogoutRequestModel.fromEntity(LogoutRequestEntity entity) {
    return LogoutRequestModel(refreshToken: entity.refreshToken);
  }

  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    return LogoutRequestModel(
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
