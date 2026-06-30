import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/chart_data_point_entity.dart';
import '../../../domain/entities/financial_summary_entity.dart';
import '../../../domain/entities/inventory_consumption_entity.dart';
import '../../../domain/entities/menu_performance_entity.dart';
import '../../../domain/entities/operational_volume_entity.dart';
import '../../../domain/entities/order_type_metric_entity.dart';
import '../../../domain/entities/status_distribution_entity.dart';

/// Identifies which report fetch action was taken.
/// Used to distinguish loading/failure states per section.
enum ReportsAction {
  financialSummary,
  revenueChart,
  menuPerformance,
  operationalVolume,
  orderStatusDistribution,
  orderTypeAnalysis,
  inventoryConsumption,
}

// ─────────────────────────────────────────────
// Base State
// ─────────────────────────────────────────────

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

// ─────────────────────────────────────────────
// Lifecycle States
// ─────────────────────────────────────────────

class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

class ReportsLoading extends ReportsState {
  const ReportsLoading(this.action);

  final ReportsAction action;

  @override
  List<Object?> get props => [action];
}

class ReportsFailure extends ReportsState {
  const ReportsFailure(this.failure, this.action);

  final AppFailure failure;
  final ReportsAction action;

  @override
  List<Object?> get props => [failure, action];
}

// ─────────────────────────────────────────────
// Success States — one per report type
// ─────────────────────────────────────────────

class FinancialSummarySuccess extends ReportsState {
  const FinancialSummarySuccess(this.summary);

  final FinancialSummaryEntity summary;

  @override
  List<Object?> get props => [summary];
}

class RevenueChartSuccess extends ReportsState {
  const RevenueChartSuccess(this.dataPoints);

  final List<ChartDataPointEntity> dataPoints;

  @override
  List<Object?> get props => [dataPoints];
}

class MenuPerformanceSuccess extends ReportsState {
  const MenuPerformanceSuccess(this.items);

  final List<MenuPerformanceEntity> items;

  @override
  List<Object?> get props => [items];
}

class OperationalVolumeSuccess extends ReportsState {
  const OperationalVolumeSuccess(this.volume);

  final OperationalVolumeEntity volume;

  @override
  List<Object?> get props => [volume];
}

class OrderStatusDistributionSuccess extends ReportsState {
  const OrderStatusDistributionSuccess(this.distribution);

  final StatusDistributionEntity distribution;

  @override
  List<Object?> get props => [distribution];
}

class OrderTypeAnalysisSuccess extends ReportsState {
  const OrderTypeAnalysisSuccess(this.metrics);

  final List<OrderTypeMetricEntity> metrics;

  @override
  List<Object?> get props => [metrics];
}

class InventoryConsumptionSuccess extends ReportsState {
  const InventoryConsumptionSuccess(this.consumption);

  final InventoryConsumptionEntity consumption;

  @override
  List<Object?> get props => [consumption];
}
