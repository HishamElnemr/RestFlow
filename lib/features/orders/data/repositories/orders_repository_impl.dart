import 'package:dartz/dartz.dart';
import 'package:rest_flow/core/errors/error_handler.dart';
import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/core/services/orders_api_service.dart';
import '../../domain/entities/order_list_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersApiService _apiService;

  OrdersRepositoryImpl(this._apiService);

  @override
  Future<Either<AppFailure, List<OrderListEntity>>> getOrders({
    String? search,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    OrderType? orderType,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final response = await _apiService.getOrders(
        search: search,
        status: status,
        paymentStatus: paymentStatus,
        orderType: orderType,
        fromDate: fromDate,
        toDate: toDate,
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
