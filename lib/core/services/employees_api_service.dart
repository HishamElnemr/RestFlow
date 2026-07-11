import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/employees/data/models/create_employee_request_model.dart';
import '../../features/employees/data/models/employee_model.dart';
import '../../features/employees/data/models/employee_response_model.dart';
import '../../features/employees/data/models/update_employee_request_model.dart';
import '../../features/employees/data/models/update_employee_status_request_model.dart';
import '../constants/api_constants.dart';

part 'employees_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class EmployeesApiService {
  factory EmployeesApiService(Dio dio, {String baseUrl}) = _EmployeesApiService;

  @GET('/api/Employees')
  Future<List<EmployeeModel>> fetchEmployees(
    @Query('search') String? search,
    @Query('role') String? role,
    @Query('status') String? status,
  );

  @POST('/api/Employees')
  Future<EmployeeResponseModel> createEmployee(
    @Body() CreateEmployeeRequestModel request,
  );

  @GET('/api/Employees/{id}')
  Future<EmployeeModel> fetchEmployeeById(@Path('id') String id);

  @PATCH('/api/Employees/{id}')
  Future<EmployeeResponseModel> updateEmployee(
    @Path('id') String id,
    @Body() UpdateEmployeeRequestModel request,
  );

  @PATCH('/api/Employees/{id}/status')
  Future<EmployeeResponseModel> updateEmployeeStatus(
    @Path('id') String id,
    @Body() UpdateEmployeeStatusRequestModel request,
  );
}
