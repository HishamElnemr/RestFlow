import 'package:equatable/equatable.dart';

import '../../domain/entities/order_list_entity.dart';
import 'package:rest_flow/core/errors/app_failure.dart';

enum OrdersAction { fetchList, fetchById, create, updateStatus, updatePaymentStatus }

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading(this.action);

  final OrdersAction action;

  @override
  List<Object?> get props => [action];
}

class OrdersListSuccess extends OrdersState {
  final List<OrderListEntity> orders;

  const OrdersListSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderDetailsSuccess extends OrdersState {
  final OrderListEntity order;

  const OrderDetailsSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class OrdersActionSuccess extends OrdersState {
  const OrdersActionSuccess(this.action);

  final OrdersAction action;

  @override
  List<Object?> get props => [action];
}

class OrdersError extends OrdersState {
  final AppFailure failure;
  final OrdersAction action;

  const OrdersError(this.failure, this.action);

  @override
  List<Object?> get props => [failure, action];
}
