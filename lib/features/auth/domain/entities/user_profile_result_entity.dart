import 'package:equatable/equatable.dart';

class UserProfileResultEntity extends Equatable {
  const UserProfileResultEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.tenantId,
    required this.status,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String? tenantId;
  final int status; // Match UserStatus Enum from C#

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phone,
        role,
        tenantId,
        status,
      ];
}
