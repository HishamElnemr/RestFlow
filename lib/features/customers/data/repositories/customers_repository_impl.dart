import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/customers_api_service.dart';
import '../../domain/entities/create_customer_request_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_response_entity.dart';
import '../../domain/entities/customer_status.dart';
import '../../domain/entities/update_customer_request_entity.dart';
import '../../domain/entities/update_customer_status_request_entity.dart';
import '../../domain/repositories/customers_repository.dart';
import '../models/create_customer_request_model.dart';
import '../models/update_customer_request_model.dart';
import '../models/update_customer_status_request_model.dart';

class CustomersRepositoryImpl implements CustomersRepository {
  CustomersRepositoryImpl({CustomersApiService? apiService})
    : _apiService = apiService ?? CustomersApiService(Dio());

  final CustomersApiService _apiService;

  @override
  Future<Either<AppFailure, List<CustomerEntity>>> fetchCustomers({
    String? search,
    CustomerStatus? status,
  }) async {
    try {
      final response = await _apiService.fetchCustomers(
        search,
        _statusToQuery(status),
      );
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, CustomerEntity>> fetchCustomerById(
    String id,
  ) async {
    try {
      final response = await _apiService.fetchCustomerById(id);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, CustomerResponseEntity>> createCustomer(
    CreateCustomerRequestEntity request,
  ) async {
    try {
      final response = await _apiService.createCustomer(
        CreateCustomerRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, CustomerResponseEntity>> updateCustomer(
    String id,
    UpdateCustomerRequestEntity request,
  ) async {
    try {
      final response = await _apiService.updateCustomer(
        id,
        UpdateCustomerRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, CustomerResponseEntity>> updateCustomerStatus(
    String id,
    UpdateCustomerStatusRequestEntity request,
  ) async {
    try {
      final response = await _apiService.updateCustomerStatus(
        id,
        UpdateCustomerStatusRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  String? _statusToQuery(CustomerStatus? status) {
    if (status == null) {
      return null;
    }
    switch (status) {
      case CustomerStatus.active:
        return 'Active';
      case CustomerStatus.inactive:
        return 'Inactive';
    }
  }
}
