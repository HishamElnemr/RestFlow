// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String,
      orderId: json['orderId'] as String? ?? '',
      productId: json['productId'] as String,
      productName: json['productName'] as String?,
      productNameSnapshot: json['productNameSnapshot'] as String?,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      lineTotal: (json['lineTotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productNameSnapshot': instance.productNameSnapshot,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'lineTotal': instance.lineTotal,
    };
