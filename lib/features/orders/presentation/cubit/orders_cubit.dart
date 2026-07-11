import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/create_order_request_entity.dart';
import '../../domain/entities/update_order_status_request_entity.dart';
import '../../domain/entities/update_payment_status_request_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';
import '../../domain/repositories/orders_repository.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _repository;

  OrdersCubit(this._repository) : super(const OrdersInitial());

  Future<void> fetchOrders({
    String? search,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    OrderType? orderType,
    String? fromDate,
    String? toDate,
  }) async {
    emit(const OrdersLoading(OrdersAction.fetchList));

    final result = await _repository.getOrders(
      search: search,
      status: status,
      paymentStatus: paymentStatus,
      orderType: orderType,
      fromDate: fromDate,
      toDate: toDate,
    );

    result.fold(
      (failure) => emit(OrdersError(failure, OrdersAction.fetchList)),
      (orders) => emit(OrdersListSuccess(orders)),
    );
  }

  Future<void> fetchOrderById(String id) async {
    emit(const OrdersLoading(OrdersAction.fetchById));

    final result = await _repository.getOrderById(id);

    result.fold(
      (failure) => emit(OrdersError(failure, OrdersAction.fetchById)),
      (order) => emit(OrderDetailsSuccess(order)),
    );
  }

  Future<void> createOrder(CreateOrderRequestEntity request) async {
    debugPrint('=== CREATE ORDER ===');
    debugPrint('customerId: ${request.customerId}');
    debugPrint('orderType: ${request.orderType}');
    debugPrint('notes: ${request.notes}');
    debugPrint('items count: ${request.items.length}');
    for (final item in request.items) {
      debugPrint('  - productId: ${item.productId}, qty: ${item.quantity}');
    }
    debugPrint('===================');

    emit(const OrdersLoading(OrdersAction.create));

    final result = await _repository.createOrder(request);

    result.fold(
      (failure) {
        debugPrint('CREATE ORDER FAILED: ${failure.message}');
        emit(OrdersError(failure, OrdersAction.create));
      },
      (_) => emit(const OrdersActionSuccess(OrdersAction.create)),
    );
  }

  Future<void> updateOrderStatus(
    String id,
    UpdateOrderStatusRequestEntity request,
  ) async {
    emit(const OrdersLoading(OrdersAction.updateStatus));

    final result = await _repository.updateOrderStatus(id, request);

    result.fold(
      (failure) => emit(OrdersError(failure, OrdersAction.updateStatus)),
      (_) => emit(const OrdersActionSuccess(OrdersAction.updateStatus)),
    );
  }

  Future<void> updatePaymentStatus(
    String id,
    UpdatePaymentStatusRequestEntity request,
  ) async {
    emit(const OrdersLoading(OrdersAction.updatePaymentStatus));

    final result = await _repository.updatePaymentStatus(id, request);

    result.fold(
      (failure) => emit(OrdersError(failure, OrdersAction.updatePaymentStatus)),
      (_) => emit(const OrdersActionSuccess(OrdersAction.updatePaymentStatus)),
    );
  }
}
