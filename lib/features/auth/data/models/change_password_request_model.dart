import '../../domain/entities/change_password_request_entity.dart';

class ChangePasswordRequestModel extends ChangePasswordRequestEntity {
  const ChangePasswordRequestModel({
    required super.currentPassword,
    required super.newPassword,
    required super.confirmNewPassword,
  });

  factory ChangePasswordRequestModel.fromEntity(
    ChangePasswordRequestEntity entity,
  ) {
    return ChangePasswordRequestModel(
      currentPassword: entity.currentPassword,
      newPassword: entity.newPassword,
      confirmNewPassword: entity.confirmNewPassword,
    );
  }

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequestModel(
      currentPassword: (json['currentPassword'] ?? '').toString(),
      newPassword: (json['newPassword'] ?? '').toString(),
      confirmNewPassword: (json['confirmNewPassword'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      };
}
