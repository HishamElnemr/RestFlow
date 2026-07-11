import 'package:flutter/foundation.dart';
import 'package:rest_flow/features/orders/domain/enums/order_type.dart';

import '../../domain/entities/create_order_request_entity.dart';

class CreateOrderRequestModel extends CreateOrderRequestEntity {
  const CreateOrderRequestModel({
    super.customerId,
    super.orderType,
    super.notes,
    required List<CreateOrderItemRequestModel> items,
  }) : super(items: items);

  factory CreateOrderRequestModel.fromEntity(CreateOrderRequestEntity entity) {
    return CreateOrderRequestModel(
      customerId: entity.customerId,
      orderType: entity.orderType,
      notes: entity.notes,
      items: entity.items
          .map((item) => CreateOrderItemRequestModel.fromEntity(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    String? orderTypeStr;
    if (orderType != null) {
      switch (orderType!) {
        case OrderType.dineIn: orderTypeStr = 'DineIn'; break;
        case OrderType.takeaway: orderTypeStr = 'Takeaway'; break;
        case OrderType.delivery: orderTypeStr = 'Delivery'; break;
      }
    }

    final json = {
      if (customerId != null) 'customerId': customerId,
      if (orderTypeStr != null) 'orderType': orderTypeStr,
      if (notes != null) 'notes': notes,
      'items': items
          .map((item) => (item as CreateOrderItemRequestModel).toJson())
          .toList(),
    };

    debugPrint('=== toJson() ===');
    debugPrint('$json');
    debugPrint('================');

    return json;
  }
}

class CreateOrderItemRequestModel extends CreateOrderItemRequestEntity {
  const CreateOrderItemRequestModel({
    required super.productId,
    super.quantity,
  });

  factory CreateOrderItemRequestModel.fromEntity(
      CreateOrderItemRequestEntity entity) {
    return CreateOrderItemRequestModel(
      productId: entity.productId,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      if (quantity != null) 'quantity': quantity,
    };
  }
}
