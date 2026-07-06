import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/orders/data/models/order_list_model.dart';
import '../../features/orders/domain/enums/order_status.dart';
import '../../features/orders/domain/enums/order_type.dart';
import '../../features/orders/domain/enums/payment_status.dart';

part 'orders_api_service.g.dart';

@RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio, {String baseUrl}) = _OrdersApiService;

  @GET('/api/Orders')
  Future<List<OrderListModel>> getOrders({
    @Query('search') String? search,
    @Query('status') OrderStatus? status,
    @Query('paymentStatus') PaymentStatus? paymentStatus,
    @Query('orderType') OrderType? orderType,
    @Query('fromDate') String? fromDate,
    @Query('toDate') String? toDate,
  });
}
