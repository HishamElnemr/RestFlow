import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/order_item_entity.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    @JsonKey(defaultValue: '') super.orderId = '',
    required super.productId,
    super.productName,
    super.productNameSnapshot,
    super.unitPrice,
    super.quantity,
    super.lineTotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
