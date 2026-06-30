import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/chart_data_point_entity.dart';
import '../entities/financial_summary_entity.dart';
import '../entities/inventory_consumption_entity.dart';
import '../entities/menu_performance_entity.dart';
import '../entities/operational_volume_entity.dart';
import '../entities/order_type_metric_entity.dart';
import '../entities/status_distribution_entity.dart';

abstract class ReportsRepository {
  /// Returns a financial summary (total revenue, growth) for the given period.
  Future<Either<AppFailure, FinancialSummaryEntity>> getFinancialSummary({
    required String from,
    required String to,
  });

  /// Returns time-series revenue data for the given period label.
  /// [period] must be one of: 'week', 'month', 'year'.
  Future<Either<AppFailure, List<ChartDataPointEntity>>> getRevenueChart({
    required String period,
  });

  /// Returns menu performance sorted by quantity sold.
  /// [sort] must be 'asc' or 'desc'.
  Future<Either<AppFailure, List<MenuPerformanceEntity>>> getMenuPerformance({
    required String from,
    required String to,
    String sort = 'desc',
  });

  /// Returns total order counts, revenue, and percentage per order type.
  Future<Either<AppFailure, OperationalVolumeEntity>> getOperationalVolume({
    required String from,
    required String to,
  });

  /// Returns the count of orders grouped by their status (pending / completed / cancelled).
  Future<Either<AppFailure, StatusDistributionEntity>> getOrderStatusDistribution({
    required String from,
    required String to,
  });

  /// Returns per-type order counts, revenue, and percentages.
  Future<Either<AppFailure, List<OrderTypeMetricEntity>>> getOrderTypeAnalysis({
    required String from,
    required String to,
  });

  /// Returns most-consumed ingredients and stock movement summaries.
  Future<Either<AppFailure, InventoryConsumptionEntity>> getInventoryConsumption({
    required String from,
    required String to,
  });
}
