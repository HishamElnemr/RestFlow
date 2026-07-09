import '../../features/reports/domain/entities/financial_summary_entity.dart';

class FinancialSummaryDummy {
  static const FinancialSummaryEntity dummy = FinancialSummaryEntity(
    totalRevenue: 12345.67,
    revenueGrowth: '+10.5%',
  );
}
