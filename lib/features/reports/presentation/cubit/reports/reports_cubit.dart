import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/reports_repository.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this._repository) : super(const ReportsInitial());

  final ReportsRepository _repository;

  // ─────────────────────────────────────────────
  // Financial Summary
  // ─────────────────────────────────────────────

  /// Fetches total revenue and revenue growth for the given date range.
  Future<void> fetchFinancialSummary({
    required String from,
    required String to,
  }) async {
    emit(const ReportsLoading(ReportsAction.financialSummary));
    final result = await _repository.getFinancialSummary(from: from, to: to);
    result.fold(
      (failure) =>
          emit(ReportsFailure(failure, ReportsAction.financialSummary)),
      (summary) => emit(FinancialSummarySuccess(summary)),
    );
  }

  // ─────────────────────────────────────────────
  // Revenue Chart
  // ─────────────────────────────────────────────

  /// Fetches time-series revenue data.
  /// [period] must be one of: 'week', 'month', 'year'.
  Future<void> fetchRevenueChart({required String period}) async {
    emit(const ReportsLoading(ReportsAction.revenueChart));
    final result = await _repository.getRevenueChart(period: period);
    result.fold(
      (failure) => emit(ReportsFailure(failure, ReportsAction.revenueChart)),
      (dataPoints) => emit(RevenueChartSuccess(dataPoints)),
    );
  }

  // ─────────────────────────────────────────────
  // Menu Performance
  // ─────────────────────────────────────────────

  /// Fetches product performance sorted by quantity sold.
  /// [sort] must be 'asc' or 'desc' (defaults to 'desc').
  Future<void> fetchMenuPerformance({
    required String from,
    required String to,
    String sort = 'desc',
  }) async {
    emit(const ReportsLoading(ReportsAction.menuPerformance));
    final result = await _repository.getMenuPerformance(
      from: from,
      to: to,
      sort: sort,
    );
    result.fold(
      (failure) =>
          emit(ReportsFailure(failure, ReportsAction.menuPerformance)),
      (items) => emit(MenuPerformanceSuccess(items)),
    );
  }

  // ─────────────────────────────────────────────
  // Operational Volume
  // ─────────────────────────────────────────────

  /// Fetches combined status distribution and order type metrics.
  Future<void> fetchOperationalVolume({
    required String from,
    required String to,
  }) async {
    emit(const ReportsLoading(ReportsAction.operationalVolume));
    final result = await _repository.getOperationalVolume(from: from, to: to);
    result.fold(
      (failure) =>
          emit(ReportsFailure(failure, ReportsAction.operationalVolume)),
      (volume) => emit(OperationalVolumeSuccess(volume)),
    );
  }

  // ─────────────────────────────────────────────
  // Order Status Distribution
  // ─────────────────────────────────────────────

  /// Fetches order counts grouped by status (pending/completed/cancelled).
  Future<void> fetchOrderStatusDistribution({
    required String from,
    required String to,
  }) async {
    emit(const ReportsLoading(ReportsAction.orderStatusDistribution));
    final result = await _repository.getOrderStatusDistribution(
      from: from,
      to: to,
    );
    result.fold(
      (failure) => emit(
        ReportsFailure(failure, ReportsAction.orderStatusDistribution),
      ),
      (distribution) => emit(OrderStatusDistributionSuccess(distribution)),
    );
  }

  // ─────────────────────────────────────────────
  // Order Type Analysis
  // ─────────────────────────────────────────────

  /// Fetches per-type order count, revenue, and percentage breakdown.
  Future<void> fetchOrderTypeAnalysis({
    required String from,
    required String to,
  }) async {
    emit(const ReportsLoading(ReportsAction.orderTypeAnalysis));
    final result = await _repository.getOrderTypeAnalysis(from: from, to: to);
    result.fold(
      (failure) =>
          emit(ReportsFailure(failure, ReportsAction.orderTypeAnalysis)),
      (metrics) => emit(OrderTypeAnalysisSuccess(metrics)),
    );
  }

  // ─────────────────────────────────────────────
  // Inventory Consumption
  // ─────────────────────────────────────────────

  /// Fetches most-consumed ingredients and stock movement summaries.
  Future<void> fetchInventoryConsumption({
    required String from,
    required String to,
  }) async {
    emit(const ReportsLoading(ReportsAction.inventoryConsumption));
    final result = await _repository.getInventoryConsumption(
      from: from,
      to: to,
    );
    result.fold(
      (failure) =>
          emit(ReportsFailure(failure, ReportsAction.inventoryConsumption)),
      (consumption) => emit(InventoryConsumptionSuccess(consumption)),
    );
  }

  // ─────────────────────────────────────────────
  // Utility
  // ─────────────────────────────────────────────

  void reset() => emit(const ReportsInitial());
}
