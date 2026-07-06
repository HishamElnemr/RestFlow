import '../../domain/entities/dashboard_insight_entity.dart';

class DashboardInsightModel extends DashboardInsightEntity {
  const DashboardInsightModel({
    required super.category,
    required super.insight,
  });

  factory DashboardInsightModel.fromJson(Map<String, dynamic> json) {
    return DashboardInsightModel(
      category: json['category'] as String? ?? '',
      insight: json['insight'] as String? ?? '',
    );
  }
}
