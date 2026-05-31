import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/create_customer_request_entity.dart';
import '../entities/customer_entity.dart';
import '../entities/customer_response_entity.dart';
import '../entities/customer_status.dart';
import '../entities/update_customer_request_entity.dart';
import '../entities/update_customer_status_request_entity.dart';

abstract class CustomersRepository {
  Future<Either<AppFailure, List<CustomerEntity>>> fetchCustomers({
    String? search,
    CustomerStatus? status,
  });

  Future<Either<AppFailure, CustomerEntity>> fetchCustomerById(String id);

  Future<Either<AppFailure, CustomerResponseEntity>> createCustomer(
    CreateCustomerRequestEntity request,
  );

  Future<Either<AppFailure, CustomerResponseEntity>> updateCustomer(
    String id,
    UpdateCustomerRequestEntity request,
  );

  Future<Either<AppFailure, CustomerResponseEntity>> updateCustomerStatus(
    String id,
    UpdateCustomerStatusRequestEntity request,
  );
}
