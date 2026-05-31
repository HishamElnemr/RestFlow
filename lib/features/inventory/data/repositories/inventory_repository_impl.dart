import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/inventory_api_service.dart';
import '../../domain/entities/create_inventory_category_request_entity.dart';
import '../../domain/entities/create_inventory_item_request_entity.dart';
import '../../domain/entities/create_stock_movement_request_entity.dart';
import '../../domain/entities/inventory_category_list_entity.dart';
import '../../domain/entities/inventory_item_details_entity.dart';
import '../../domain/entities/inventory_item_list_entity.dart';
import '../../domain/entities/low_stock_alert_entity.dart';
import '../../domain/entities/message_response_entity.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/entities/update_inventory_category_request_entity.dart';
import '../../domain/entities/update_inventory_item_request_entity.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../models/create_inventory_category_request_model.dart';
import '../models/create_inventory_item_request_model.dart';
import '../models/create_stock_movement_request_model.dart';
import '../models/update_inventory_category_request_model.dart';
import '../models/update_inventory_item_request_model.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  InventoryRepositoryImpl({InventoryApiService? apiService})
    : _apiService = apiService ?? InventoryApiService(Dio());

  final InventoryApiService _apiService;

  @override
  Future<Either<AppFailure, List<InventoryItemListEntity>>>
  fetchInventoryItems({String? search, String? categoryId}) async {
    try {
      final response = await _apiService.fetchInventoryItems(
        search,
        categoryId,
      );
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, InventoryItemDetailsEntity>>
  fetchInventoryItemDetails(String id) async {
    try {
      final response = await _apiService.fetchInventoryItemDetails(id);
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, String>> createInventoryItem(
    CreateInventoryItemRequestEntity request,
  ) async {
    try {
      final response = await _apiService.createInventoryItem(
        CreateInventoryItemRequestModel.fromEntity(request),
      );
      return Right(response.toString());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> updateInventoryItem(
    String id,
    UpdateInventoryItemRequestEntity request,
  ) async {
    try {
      await _apiService.updateInventoryItem(
        id,
        UpdateInventoryItemRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> deactivateInventoryItem(String id) async {
    try {
      await _apiService.deactivateInventoryItem(id);
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> createStockMovement(
    String itemId,
    CreateStockMovementRequestEntity request,
  ) async {
    try {
      await _apiService.createStockMovement(
        itemId,
        CreateStockMovementRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<StockMovementEntity>>> fetchStockMovements(
    String itemId,
  ) async {
    try {
      final response = await _apiService.fetchStockMovements(itemId);
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<InventoryCategoryListEntity>>>
  fetchInventoryCategories() async {
    try {
      final response = await _apiService.fetchInventoryCategories();
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, String>> createInventoryCategory(
    CreateInventoryCategoryRequestEntity request,
  ) async {
    try {
      final response = await _apiService.createInventoryCategory(
        CreateInventoryCategoryRequestModel.fromEntity(request),
      );
      return Right(response.toString());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, MessageResponseEntity>> updateInventoryCategory(
    String id,
    UpdateInventoryCategoryRequestEntity request,
  ) async {
    try {
      final response = await _apiService.updateInventoryCategory(
        id,
        UpdateInventoryCategoryRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, List<LowStockAlertEntity>>>
  fetchLowStockAlerts() async {
    try {
      final response = await _apiService.fetchLowStockAlerts();
      return Right(response.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
