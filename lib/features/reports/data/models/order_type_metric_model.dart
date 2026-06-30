import '../../domain/entities/order_type_metric_entity.dart';

class OrderTypeMetricModel extends OrderTypeMetricEntity {
  const OrderTypeMetricModel({
    required super.orderType,
    required super.count,
    required super.revenue,
    required super.percentage,
  });

  factory OrderTypeMetricModel.fromJson(Map<String, dynamic> json) {
    return OrderTypeMetricModel(
      orderType: json['orderType'] as String,
      count: json['count'] as int? ?? 0,
      revenue: (json['revenue'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderType': orderType,
      'count': count,
      'revenue': revenue,
      'percentage': percentage,
    };
  }

  OrderTypeMetricEntity toEntity() {
    return OrderTypeMetricEntity(
      orderType: orderType,
      count: count,
      revenue: revenue,
      percentage: percentage,
    );
  }
}
