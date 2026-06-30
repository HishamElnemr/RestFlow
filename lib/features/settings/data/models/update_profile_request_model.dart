import '../../domain/entities/update_profile_request_entity.dart';

class UpdateProfileRequestModel extends UpdateProfileRequestEntity {
  const UpdateProfileRequestModel({
    required super.fullName,
    required super.preferredLanguage,
  });

  factory UpdateProfileRequestModel.fromEntity(
    UpdateProfileRequestEntity entity,
  ) {
    return UpdateProfileRequestModel(
      fullName: entity.fullName,
      preferredLanguage: entity.preferredLanguage,
    );
  }

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequestModel(
      fullName: (json['fullName'] ?? '').toString(),
      preferredLanguage: (json['preferredLanguage'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'preferredLanguage': preferredLanguage,
      };
}
