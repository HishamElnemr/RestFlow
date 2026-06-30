import 'package:equatable/equatable.dart';

class OrderTypeMetricEntity extends Equatable {
  const OrderTypeMetricEntity({
    required this.orderType,
    required this.count,
    required this.revenue,
    required this.percentage,
  });

  final String orderType;
  final int count;
  final double revenue;
  final double percentage;

  @override
  List<Object?> get props => [orderType, count, revenue, percentage];
}
