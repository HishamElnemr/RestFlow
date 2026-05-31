import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/customers/data/models/create_customer_request_model.dart';
import '../../features/customers/data/models/customer_model.dart';
import '../../features/customers/data/models/customer_response_model.dart';
import '../../features/customers/data/models/update_customer_request_model.dart';
import '../../features/customers/data/models/update_customer_status_request_model.dart';
import '../constants/api_constants.dart';
part 'customers_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CustomersApiService {
  factory CustomersApiService(Dio dio, {String baseUrl}) = _CustomersApiService;

  @GET('/api/Customers')
  Future<List<CustomerModel>> fetchCustomers(
    @Query('search') String? search,
    @Query('customerStatus') String? customerStatus,
  );

  @POST('/api/Customers')
  Future<CustomerResponseModel> createCustomer(
    @Body() CreateCustomerRequestModel request,
  );

  @GET('/api/Customers/{id}')
  Future<CustomerModel> fetchCustomerById(@Path('id') String id);

  @PATCH('/api/Customers/{id}')
  Future<CustomerResponseModel> updateCustomer(
    @Path('id') String id,
    @Body() UpdateCustomerRequestModel request,
  );

  @PATCH('/api/Customers/{id}/status')
  Future<CustomerResponseModel> updateCustomerStatus(
    @Path('id') String id,
    @Body() UpdateCustomerStatusRequestModel request,
  );
}
