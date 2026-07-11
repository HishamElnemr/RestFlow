import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/employee_status.dart';

class EmployeeModel {
  const EmployeeModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      status: json['status'].toString(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      role: role,
      status: _mapStatus(status),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  EmployeeStatus _mapStatus(String statusStr) {
    final lower = statusStr.toLowerCase();
    if (lower == '0' || lower == 'active') {
      return EmployeeStatus.active;
    } else if (lower == '1' || lower == 'inactive') {
      return EmployeeStatus.inactive;
    }
    return EmployeeStatus.active;
  }
}
