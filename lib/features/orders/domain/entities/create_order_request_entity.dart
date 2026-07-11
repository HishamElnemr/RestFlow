import 'package:equatable/equatable.dart';

import '../enums/order_type.dart';

class CreateOrderRequestEntity extends Equatable {
  const CreateOrderRequestEntity({
    this.customerId,
    this.orderType,
    this.notes,
    required this.items,
  });

  final String? customerId;
  final OrderType? orderType;
  final String? notes;
  final List<CreateOrderItemRequestEntity> items;

  @override
  List<Object?> get props => [
        customerId,
        orderType,
        notes,
        items,
      ];
}

class CreateOrderItemRequestEntity extends Equatable {
  const CreateOrderItemRequestEntity({
    required this.productId,
    this.quantity,
  });

  final String productId;
  final double? quantity;

  @override
  List<Object?> get props => [
        productId,
        quantity,
      ];
}
