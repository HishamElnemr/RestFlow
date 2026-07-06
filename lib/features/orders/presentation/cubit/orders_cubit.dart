import 'package:flutter_bloc/flutter_bloc.dart';

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
    emit(const OrdersLoading());

    final result = await _repository.getOrders(
      search: search,
      status: status,
      paymentStatus: paymentStatus,
      orderType: orderType,
      fromDate: fromDate,
      toDate: toDate,
    );

    result.fold(
      (failure) => emit(OrdersError(failure)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
