import '../../domain/entities/chart_data_point_entity.dart';

class ChartDataPointModel extends ChartDataPointEntity {
  const ChartDataPointModel({
    required super.label,
    required super.amount,
  });

  factory ChartDataPointModel.fromJson(Map<String, dynamic> json) {
    return ChartDataPointModel(
      label: json['label'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'amount': amount,
    };
  }

  ChartDataPointEntity toEntity() {
    return ChartDataPointEntity(label: label, amount: amount);
  }
}
