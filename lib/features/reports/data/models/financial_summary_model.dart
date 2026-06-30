import '../../domain/entities/financial_summary_entity.dart';

class FinancialSummaryModel extends FinancialSummaryEntity {
  const FinancialSummaryModel({
    required super.totalRevenue,
    required super.revenueGrowth,
  });

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) {
    return FinancialSummaryModel(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      revenueGrowth: json['revenueGrowth'] as String? ?? '0.0%',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRevenue': totalRevenue,
      'revenueGrowth': revenueGrowth,
    };
  }

  FinancialSummaryEntity toEntity() {
    return FinancialSummaryEntity(
      totalRevenue: totalRevenue,
      revenueGrowth: revenueGrowth,
    );
  }
}
