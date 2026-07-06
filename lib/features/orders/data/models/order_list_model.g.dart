// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListModel _$OrderListModelFromJson(Map<String, dynamic> json) =>
    OrderListModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String?,
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      orderStatus:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['orderStatus']),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['paymentStatus']),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderListModelToJson(OrderListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'orderType': _$OrderTypeEnumMap[instance.orderType],
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus],
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus],
      'subtotal': instance.subtotal,
      'totalAmount': instance.totalAmount,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

const _$OrderTypeEnumMap = {
  OrderType.dineIn: 1,
  OrderType.takeaway: 2,
  OrderType.delivery: 3,
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 1,
  OrderStatus.completed: 2,
  OrderStatus.cancelled: 3,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.unpaid: 1,
  PaymentStatus.paid: 2,
};
