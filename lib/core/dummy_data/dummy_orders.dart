import 'package:rest_flow/features/orders/domain/entities/order_list_entity.dart';
import 'package:rest_flow/features/orders/domain/enums/order_status.dart';
import 'package:rest_flow/features/orders/domain/enums/order_type.dart';
import 'package:rest_flow/features/orders/domain/enums/payment_status.dart';

final dummyOrders = [
  const OrderListEntity(
    id: '1',
    orderNumber: 'ORD-1234',
    orderType: OrderType.dineIn,
    orderStatus: OrderStatus.pending,
    paymentStatus: PaymentStatus.unpaid,
    totalAmount: 48.5,
  ),
  const OrderListEntity(
    id: '2',
    orderNumber: 'ORD-1235',
    orderType: OrderType.delivery,
    orderStatus: OrderStatus.completed,
    paymentStatus: PaymentStatus.paid,
    totalAmount: 125.0,
  ),
  const OrderListEntity(
    id: '3',
    orderNumber: 'ORD-1236',
    orderType: OrderType.takeaway,
    orderStatus: OrderStatus.completed,
    paymentStatus: PaymentStatus.paid,
    totalAmount: 32.5,
  ),
];
