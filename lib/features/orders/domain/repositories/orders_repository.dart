import 'package:dartz/dartz.dart';
import 'package:rest_flow/core/errors/app_failure.dart';
import '../entities/order_list_entity.dart';
import '../enums/order_status.dart';
import '../enums/order_type.dart';
import '../enums/payment_status.dart';
import '../entities/create_order_request_entity.dart';
import '../entities/update_order_status_request_entity.dart';
import '../entities/update_payment_status_request_entity.dart';

abstract class OrdersRepository {
  Future<Either<AppFailure, List<OrderListEntity>>> getOrders({
    String? search,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    OrderType? orderType,
    String? fromDate,
    String? toDate,
  });

  Future<Either<AppFailure, String>> createOrder(
    CreateOrderRequestEntity request,
  );

  Future<Either<AppFailure, OrderListEntity>> getOrderById(
    String id,
  );

  Future<Either<AppFailure, void>> updateOrderStatus(
    String id,
    UpdateOrderStatusRequestEntity request,
  );

  Future<Either<AppFailure, void>> updatePaymentStatus(
    String id,
    UpdatePaymentStatusRequestEntity request,
  );
}
