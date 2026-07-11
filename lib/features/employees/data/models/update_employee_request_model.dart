import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_request_entity.dart';

class UpdateEmployeeRequestModel {
  const UpdateEmployeeRequestModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.role,
    this.status,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final int? status;

  factory UpdateEmployeeRequestModel.fromEntity(
      UpdateEmployeeRequestEntity entity) {
    return UpdateEmployeeRequestModel(
      fullName: entity.fullName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
      status: entity.status != null ? _mapStatusToInt(entity.status!) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fullName != null) data['fullName'] = fullName;
    if (email != null) data['email'] = email;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (role != null) data['role'] = role;
    if (status != null) data['status'] = status;
    return data;
  }

  static int _mapStatusToInt(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return 0;
      case EmployeeStatus.inactive:
        return 1;
    }
  }
}
