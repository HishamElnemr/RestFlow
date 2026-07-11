import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/employees_api_service.dart';
import '../../domain/entities/create_employee_request_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/employee_response_entity.dart';
import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_request_entity.dart';
import '../../domain/entities/update_employee_status_request_entity.dart';
import '../../domain/repositories/employees_repository.dart';
import '../models/create_employee_request_model.dart';
import '../models/update_employee_request_model.dart';
import '../models/update_employee_status_request_model.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  EmployeesRepositoryImpl({EmployeesApiService? apiService})
      : _apiService = apiService ?? EmployeesApiService(Dio());

  final EmployeesApiService _apiService;

  @override
  Future<Either<AppFailure, List<EmployeeEntity>>> fetchEmployees({
    String? search,
    String? role,
    EmployeeStatus? status,
  }) async {
    try {
      final response = await _apiService.fetchEmployees(
        search,
        role,
        _statusToQuery(status),
      );
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, EmployeeEntity>> fetchEmployeeById(
    String id,
  ) async {
    try {
      final response = await _apiService.fetchEmployeeById(id);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, EmployeeResponseEntity>> createEmployee(
    CreateEmployeeRequestEntity request,
  ) async {
    try {
      final response = await _apiService.createEmployee(
        CreateEmployeeRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, EmployeeResponseEntity>> updateEmployee(
    String id,
    UpdateEmployeeRequestEntity request,
  ) async {
    try {
      final response = await _apiService.updateEmployee(
        id,
        UpdateEmployeeRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, EmployeeResponseEntity>> updateEmployeeStatus(
    String id,
    UpdateEmployeeStatusRequestEntity request,
  ) async {
    try {
      final response = await _apiService.updateEmployeeStatus(
        id,
        UpdateEmployeeStatusRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  String? _statusToQuery(EmployeeStatus? status) {
    if (status == null) {
      return null;
    }
    switch (status) {
      case EmployeeStatus.active:
        return 'Active';
      case EmployeeStatus.inactive:
        return 'Inactive';
    }
  }
}
