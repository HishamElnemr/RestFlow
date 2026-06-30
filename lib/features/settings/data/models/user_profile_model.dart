import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.fullName,
    super.profileImageUrl,
    required super.preferredLanguage,
    required super.email,
    required super.phoneNumber,
  });

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      fullName: fullName,
      profileImageUrl: profileImageUrl,
      preferredLanguage: preferredLanguage,
      email: email,
      phoneNumber: phoneNumber,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      fullName: (json['fullName'] ?? '').toString(),
      profileImageUrl: json['profileImageUrl']?.toString(),
      preferredLanguage: (json['preferredLanguage'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'profileImageUrl': profileImageUrl,
        'preferredLanguage': preferredLanguage,
        'email': email,
        'phoneNumber': phoneNumber,
      };
}
