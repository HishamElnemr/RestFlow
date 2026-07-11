import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/create_employee_request_entity.dart';
import '../entities/employee_entity.dart';
import '../entities/employee_response_entity.dart';
import '../entities/employee_status.dart';
import '../entities/update_employee_request_entity.dart';
import '../entities/update_employee_status_request_entity.dart';

abstract class EmployeesRepository {
  Future<Either<AppFailure, List<EmployeeEntity>>> fetchEmployees({
    String? search,
    String? role,
    EmployeeStatus? status,
  });

  Future<Either<AppFailure, EmployeeEntity>> fetchEmployeeById(String id);

  Future<Either<AppFailure, EmployeeResponseEntity>> createEmployee(
    CreateEmployeeRequestEntity request,
  );

  Future<Either<AppFailure, EmployeeResponseEntity>> updateEmployee(
    String id,
    UpdateEmployeeRequestEntity request,
  );

  Future<Either<AppFailure, EmployeeResponseEntity>> updateEmployeeStatus(
    String id,
    UpdateEmployeeStatusRequestEntity request,
  );
}
