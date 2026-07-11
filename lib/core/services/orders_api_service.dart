import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/orders/data/models/create_order_request_model.dart';
import '../../features/orders/data/models/order_list_model.dart';
import '../../features/orders/data/models/update_order_status_request_model.dart';
import '../../features/orders/data/models/update_payment_status_request_model.dart';

part 'orders_api_service.g.dart';

@RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio, {String baseUrl}) = _OrdersApiService;

  @GET('/api/Orders')
  Future<List<OrderListModel>> getOrders({
    @Query('search') String? search,
    @Query('status') int? status,
    @Query('paymentStatus') int? paymentStatus,
    @Query('orderType') int? orderType,
    @Query('fromDate') String? fromDate,
    @Query('toDate') String? toDate,
  });

  @POST('/api/Orders')
  Future<String> createOrder(
    @Body() CreateOrderRequestModel request,
  );

  @GET('/api/Orders/{id}')
  Future<OrderListModel> getOrderById(
    @Path('id') String id,
  );

  @PATCH('/api/Orders/{id}/status')
  Future<void> updateOrderStatus(
    @Path('id') String id,
    @Body() UpdateOrderStatusRequestModel request,
  );

  @PATCH('/api/Orders/{id}/payment-status')
  Future<void> updatePaymentStatus(
    @Path('id') String id,
    @Body() UpdatePaymentStatusRequestModel request,
  );
}
