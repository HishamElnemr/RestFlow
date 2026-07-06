import 'package:equatable/equatable.dart';

import '../../domain/entities/order_list_entity.dart';
import 'package:rest_flow/core/errors/app_failure.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final List<OrderListEntity> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final AppFailure failure;

  const OrdersError(this.failure);

  @override
  List<Object?> get props => [failure];
}
