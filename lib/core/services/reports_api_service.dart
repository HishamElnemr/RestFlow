import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/reports/data/models/chart_data_point_model.dart';
import '../../features/reports/data/models/financial_summary_model.dart';
import '../../features/reports/data/models/inventory_consumption_model.dart';
import '../../features/reports/data/models/menu_performance_model.dart';
import '../../features/reports/data/models/operational_volume_model.dart';
import '../../features/reports/data/models/order_type_metric_model.dart';
import '../../features/reports/data/models/status_distribution_model.dart';
import '../constants/api_constants.dart';

part 'reports_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ReportsApiService {
  factory ReportsApiService(Dio dio, {String baseUrl}) = _ReportsApiService;

  /// GET /api/Reports/financial-summary?from=&to=
  @GET('/api/Reports/financial-summary')
  Future<FinancialSummaryModel> getFinancialSummary(
    @Query('from') String from,
    @Query('to') String to,
  );

  /// GET /api/Reports/revenue-chart?period=week|month|year
  @GET('/api/Reports/revenue-chart')
  Future<List<ChartDataPointModel>> getRevenueChart(
    @Query('period') String period,
  );

  /// GET /api/Reports/menu-performance?from=&to=&sort=asc|desc
  @GET('/api/Reports/menu-performance')
  Future<List<MenuPerformanceModel>> getMenuPerformance(
    @Query('from') String from,
    @Query('to') String to,
    @Query('sort') String sort,
  );

  /// GET /api/Reports/operational-volume?from=&to=
  @GET('/api/Reports/operational-volume')
  Future<OperationalVolumeModel> getOperationalVolume(
    @Query('from') String from,
    @Query('to') String to,
  );

  /// GET /api/Reports/order-status-distribution?from=&to=
  @GET('/api/Reports/order-status-distribution')
  Future<StatusDistributionModel> getOrderStatusDistribution(
    @Query('from') String from,
    @Query('to') String to,
  );

  /// GET /api/Reports/order-type-analysis?from=&to=
  @GET('/api/Reports/order-type-analysis')
  Future<List<OrderTypeMetricModel>> getOrderTypeAnalysis(
    @Query('from') String from,
    @Query('to') String to,
  );

  /// GET /api/Reports/inventory-consumption?from=&to=
  @GET('/api/Reports/inventory-consumption')
  Future<InventoryConsumptionModel> getInventoryConsumption(
    @Query('from') String from,
    @Query('to') String to,
  );
}
