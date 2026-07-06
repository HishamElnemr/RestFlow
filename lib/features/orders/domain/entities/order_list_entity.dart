import '../enums/order_status.dart';
import '../enums/order_type.dart';
import '../enums/payment_status.dart';
import 'order_item_entity.dart';

class OrderListEntity {
  final String id;
  final String? orderNumber;
  final OrderType? orderType;
  final OrderStatus? orderStatus;
  final PaymentStatus? paymentStatus;
  final double? subtotal;
  final double? totalAmount;
  final List<OrderItemEntity> items;

  const OrderListEntity({
    required this.id,
    this.orderNumber,
    this.orderType,
    this.orderStatus,
    this.paymentStatus,
    this.subtotal,
    this.totalAmount,
    this.items = const [],
  });
}
