import 'package:equatable/equatable.dart';

class FinancialSummaryEntity extends Equatable {
  const FinancialSummaryEntity({
    required this.totalRevenue,
    required this.revenueGrowth,
  });

  final double totalRevenue;
  final String revenueGrowth;

  @override
  List<Object?> get props => [totalRevenue, revenueGrowth];
}
