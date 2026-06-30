import '../../domain/entities/forgot_password_request_entity.dart';

class ForgotPasswordRequestModel extends ForgotPasswordRequestEntity {
  const ForgotPasswordRequestModel({required super.identifier});

  factory ForgotPasswordRequestModel.fromEntity(
    ForgotPasswordRequestEntity entity,
  ) {
    return ForgotPasswordRequestModel(identifier: entity.identifier);
  }

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestModel(
      identifier: (json['identifier'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'identifier': identifier};
}
