import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/orders/data/models/order_list_model.dart';

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
}
