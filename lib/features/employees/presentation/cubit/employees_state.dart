import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/employee_response_entity.dart';

enum EmployeesAction {
  fetchList,
  fetchById,
  create,
  update,
  updateStatus,
}

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object?> get props => [];
}

class EmployeesInitial extends EmployeesState {
  const EmployeesInitial();
}

class EmployeesLoading extends EmployeesState {
  const EmployeesLoading(this.action);

  final EmployeesAction action;

  @override
  List<Object?> get props => [action];
}

class EmployeesListSuccess extends EmployeesState {
  const EmployeesListSuccess(this.employees);

  final List<EmployeeEntity> employees;

  @override
  List<Object?> get props => [employees];
}

class EmployeeDetailsSuccess extends EmployeesState {
  const EmployeeDetailsSuccess(this.employee);

  final EmployeeEntity employee;

  @override
  List<Object?> get props => [employee];
}

class EmployeeActionSuccess extends EmployeesState {
  const EmployeeActionSuccess(this.response, this.action);

  final EmployeeResponseEntity response;
  final EmployeesAction action;

  @override
  List<Object?> get props => [response, action];
}

class EmployeesFailure extends EmployeesState {
  const EmployeesFailure(this.failure, this.action);

  final AppFailure failure;
  final EmployeesAction action;

  @override
  List<Object?> get props => [failure, action];
}
