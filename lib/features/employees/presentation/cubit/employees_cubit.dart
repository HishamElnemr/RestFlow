import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/create_employee_request_entity.dart';
import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_request_entity.dart';
import '../../domain/entities/update_employee_status_request_entity.dart';
import '../../domain/repositories/employees_repository.dart';
import 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this._repository) : super(const EmployeesInitial());

  final EmployeesRepository _repository;

  Future<void> fetchEmployees({String? search, String? role, EmployeeStatus? status}) async {
    emit(const EmployeesLoading(EmployeesAction.fetchList));
    final result = await _repository.fetchEmployees(
      search: search,
      role: role,
      status: status,
    );
    result.fold(
      (failure) => emit(EmployeesFailure(failure, EmployeesAction.fetchList)),
      (employees) => emit(EmployeesListSuccess(employees)),
    );
  }

  Future<void> fetchEmployeeById(String id) async {
    emit(const EmployeesLoading(EmployeesAction.fetchById));
    final result = await _repository.fetchEmployeeById(id);
    result.fold(
      (failure) => emit(EmployeesFailure(failure, EmployeesAction.fetchById)),
      (employee) => emit(EmployeeDetailsSuccess(employee)),
    );
  }

  Future<void> createEmployee(CreateEmployeeRequestEntity request) async {
    emit(const EmployeesLoading(EmployeesAction.create));
    final result = await _repository.createEmployee(request);
    result.fold(
      (failure) => emit(EmployeesFailure(failure, EmployeesAction.create)),
      (response) =>
          emit(EmployeeActionSuccess(response, EmployeesAction.create)),
    );
  }

  Future<void> updateEmployee(
    String id,
    UpdateEmployeeRequestEntity request,
  ) async {
    emit(const EmployeesLoading(EmployeesAction.update));
    final result = await _repository.updateEmployee(id, request);
    result.fold(
      (failure) => emit(EmployeesFailure(failure, EmployeesAction.update)),
      (response) =>
          emit(EmployeeActionSuccess(response, EmployeesAction.update)),
    );
  }

  Future<void> updateEmployeeStatus(
    String id,
    UpdateEmployeeStatusRequestEntity request,
  ) async {
    emit(const EmployeesLoading(EmployeesAction.updateStatus));
    final result = await _repository.updateEmployeeStatus(id, request);
    result.fold(
      (failure) =>
          emit(EmployeesFailure(failure, EmployeesAction.updateStatus)),
      (response) =>
          emit(EmployeeActionSuccess(response, EmployeesAction.updateStatus)),
    );
  }

  void reset() {
    emit(const EmployeesInitial());
  }
}
