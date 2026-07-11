import 'package:equatable/equatable.dart';

import 'employee_entity.dart';

class EmployeeResponseEntity extends Equatable {
  const EmployeeResponseEntity({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  final bool isSuccess;
  final String message;
  final EmployeeEntity? data;

  @override
  List<Object?> get props => [isSuccess, message, data];
}
