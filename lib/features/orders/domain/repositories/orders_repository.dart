import 'package:dartz/dartz.dart';
import 'package:rest_flow/core/errors/app_failure.dart';
import '../entities/order_list_entity.dart';
import '../enums/order_status.dart';
import '../enums/order_type.dart';
import '../enums/payment_status.dart';

abstract class OrdersRepository {
  Future<Either<AppFailure, List<OrderListEntity>>> getOrders({
    String? search,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    OrderType? orderType,
    String? fromDate,
    String? toDate,
  });
}
