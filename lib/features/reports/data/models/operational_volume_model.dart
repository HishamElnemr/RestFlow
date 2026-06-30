import '../../domain/entities/operational_volume_entity.dart';
import 'status_distribution_model.dart';
import 'order_type_metric_model.dart';

class OperationalVolumeModel extends OperationalVolumeEntity {
  const OperationalVolumeModel({
    required StatusDistributionModel statusDistribution,
    required List<OrderTypeMetricModel> orderTypeMetrics,
  }) : super(
         statusDistribution: statusDistribution,
         orderTypeMetrics: orderTypeMetrics,
       );

  factory OperationalVolumeModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> statusJson =
        json['statusDistribution'] as Map<String, dynamic>? ?? {};
    final List<dynamic> metricsJson =
        json['orderTypeMetrics'] as List<dynamic>? ?? [];

    return OperationalVolumeModel(
      statusDistribution: StatusDistributionModel.fromJson(statusJson),
      orderTypeMetrics: metricsJson
          .map(
            (e) => OrderTypeMetricModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusDistribution':
          (statusDistribution as StatusDistributionModel).toJson(),
      'orderTypeMetrics': orderTypeMetrics
          .map((e) => (e as OrderTypeMetricModel).toJson())
          .toList(),
    };
  }

  OperationalVolumeEntity toEntity() => this;
}
