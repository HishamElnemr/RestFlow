import 'package:json_annotation/json_annotation.dart';
import 'package:rest_flow/features/orders/domain/enums/order_status.dart';
import 'package:rest_flow/features/orders/domain/enums/order_type.dart';
import 'package:rest_flow/features/orders/domain/enums/payment_status.dart';

import '../../domain/entities/order_list_entity.dart';
import 'order_item_model.dart';

part 'order_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderListModel extends OrderListEntity {
  @override
  @JsonKey(defaultValue: [])
  final List<OrderItemModel> items;

  const OrderListModel({
    required super.id,
    super.orderNumber,
    super.orderType,
    super.orderStatus,
    super.paymentStatus,
    super.subtotal,
    super.totalAmount,
    this.items = const [],
  }) : super(items: items);

  factory OrderListModel.fromJson(Map<String, dynamic> json) =>
      _$OrderListModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListModelToJson(this);
}
