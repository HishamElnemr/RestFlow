import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/reports_api_service.dart';
import '../../domain/entities/chart_data_point_entity.dart';
import '../../domain/entities/financial_summary_entity.dart';
import '../../domain/entities/inventory_consumption_entity.dart';
import '../../domain/entities/menu_performance_entity.dart';
import '../../domain/entities/operational_volume_entity.dart';
import '../../domain/entities/order_type_metric_entity.dart';
import '../../domain/entities/status_distribution_entity.dart';
import '../../domain/repositories/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  ReportsRepositoryImpl({required ReportsApiService apiService})
    : _apiService = apiService;

  final ReportsApiService _apiService;

  @override
  Future<Either<AppFailure, FinancialSummaryEntity>> getFinancialSummary({
    required String from,
    required String to,
  }) async {
    try {
      final response = await _apiService.getFinancialSummary(from, to);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<ChartDataPointEntity>>> getRevenueChart({
    required String period,
  }) async {
    try {
      final response = await _apiService.getRevenueChart(period);
      return Right(response.map((m) => m.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<MenuPerformanceEntity>>> getMenuPerformance({
    required String from,
    required String to,
    String sort = 'desc',
  }) async {
    try {
      final response = await _apiService.getMenuPerformance(from, to, sort);
      return Right(response.map((m) => m.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, OperationalVolumeEntity>> getOperationalVolume({
    required String from,
    required String to,
  }) async {
    try {
      final response = await _apiService.getOperationalVolume(from, to);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, StatusDistributionEntity>>
  getOrderStatusDistribution({
    required String from,
    required String to,
  }) async {
    try {
      final response = await _apiService.getOrderStatusDistribution(from, to);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<OrderTypeMetricEntity>>> getOrderTypeAnalysis({
    required String from,
    required String to,
  }) async {
    try {
      final response = await _apiService.getOrderTypeAnalysis(from, to);
      return Right(response.map((m) => m.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, InventoryConsumptionEntity>>
  getInventoryConsumption({
    required String from,
    required String to,
  }) async {
    try {
      final response = await _apiService.getInventoryConsumption(from, to);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
