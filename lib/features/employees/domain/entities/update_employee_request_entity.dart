import 'package:equatable/equatable.dart';

import 'employee_status.dart';

class UpdateEmployeeRequestEntity extends Equatable {
  const UpdateEmployeeRequestEntity({
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
  final EmployeeStatus? status;

  @override
  List<Object?> get props => [fullName, email, phoneNumber, role, status];
}
