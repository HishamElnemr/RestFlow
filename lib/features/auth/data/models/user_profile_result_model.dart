import '../../domain/entities/user_profile_result_entity.dart';

class UserProfileResultModel extends UserProfileResultEntity {
  const UserProfileResultModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
    super.tenantId,
    required super.status,
  });

  UserProfileResultEntity toEntity() {
    return UserProfileResultEntity(
      id: id,
      fullName: fullName,
      email: email,
      phone: phone,
      role: role,
      tenantId: tenantId,
      status: status,
    );
  }

  factory UserProfileResultModel.fromJson(Map<String, dynamic> json) {
    return UserProfileResultModel(
      id: (json['id'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      tenantId: json['tenantId']?.toString(),
      status: json['status'] is int ? json['status'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': role,
        'tenantId': tenantId,
        'status': status,
      };
}
