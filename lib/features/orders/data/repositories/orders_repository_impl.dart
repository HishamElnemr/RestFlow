import 'package:dartz/dartz.dart';
import 'package:rest_flow/core/errors/error_handler.dart';
import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/core/services/orders_api_service.dart';
import '../../domain/entities/order_list_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/entities/create_order_request_entity.dart';
import '../../domain/entities/update_order_status_request_entity.dart';
import '../../domain/entities/update_payment_status_request_entity.dart';
import '../models/create_order_request_model.dart';
import '../models/update_order_status_request_model.dart';
import '../models/update_payment_status_request_model.dart';

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
        status: status?.value,
        paymentStatus: paymentStatus?.value,
        orderType: orderType?.value,
        fromDate: fromDate,
        toDate: toDate,
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, String>> createOrder(
    CreateOrderRequestEntity request,
  ) async {
    try {
      final response = await _apiService.createOrder(
        CreateOrderRequestModel.fromEntity(request),
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, OrderListEntity>> getOrderById(
    String id,
  ) async {
    try {
      final response = await _apiService.getOrderById(id);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateOrderStatus(
    String id,
    UpdateOrderStatusRequestEntity request,
  ) async {
    try {
      await _apiService.updateOrderStatus(
        id,
        UpdateOrderStatusRequestModel.fromEntity(request),
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> updatePaymentStatus(
    String id,
    UpdatePaymentStatusRequestEntity request,
  ) async {
    try {
      await _apiService.updatePaymentStatus(
        id,
        UpdatePaymentStatusRequestModel.fromEntity(request),
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
