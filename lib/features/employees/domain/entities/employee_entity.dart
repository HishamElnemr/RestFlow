import 'package:equatable/equatable.dart';

import 'employee_status.dart';

class EmployeeEntity extends Equatable {
  const EmployeeEntity({
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
  final EmployeeStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNumber,
        role,
        status,
        createdAt,
        updatedAt,
      ];
}
