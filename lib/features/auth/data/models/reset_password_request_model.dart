import '../../domain/entities/reset_password_request_entity.dart';

class ResetPasswordRequestModel extends ResetPasswordRequestEntity {
  const ResetPasswordRequestModel({
    required super.identifier,
    required super.otpCode,
    required super.newPassword,
  });

  factory ResetPasswordRequestModel.fromEntity(
    ResetPasswordRequestEntity entity,
  ) {
    return ResetPasswordRequestModel(
      identifier: entity.identifier,
      otpCode: entity.otpCode,
      newPassword: entity.newPassword,
    );
  }

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestModel(
      identifier: (json['identifier'] ?? '').toString(),
      otpCode: (json['otpCode'] ?? '').toString(),
      newPassword: (json['newPassword'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'otpCode': otpCode,
        'newPassword': newPassword,
      };
}
