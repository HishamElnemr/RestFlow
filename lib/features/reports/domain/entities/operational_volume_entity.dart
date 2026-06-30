import 'package:equatable/equatable.dart';

import 'status_distribution_entity.dart';
import 'order_type_metric_entity.dart';

class OperationalVolumeEntity extends Equatable {
  const OperationalVolumeEntity({
    required this.statusDistribution,
    required this.orderTypeMetrics,
  });

  final StatusDistributionEntity statusDistribution;
  final List<OrderTypeMetricEntity> orderTypeMetrics;

  @override
  List<Object?> get props => [statusDistribution, orderTypeMetrics];
}
