import 'package:equatable/equatable.dart';

import 'employee_status.dart';

class UpdateEmployeeStatusRequestEntity extends Equatable {
  const UpdateEmployeeStatusRequestEntity({required this.status});

  final EmployeeStatus status;

  @override
  List<Object?> get props => [status];
}
