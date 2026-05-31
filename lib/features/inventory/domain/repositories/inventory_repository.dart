import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/create_inventory_category_request_entity.dart';
import '../entities/create_inventory_item_request_entity.dart';
import '../entities/create_stock_movement_request_entity.dart';
import '../entities/inventory_category_list_entity.dart';
import '../entities/inventory_item_details_entity.dart';
import '../entities/inventory_item_list_entity.dart';
import '../entities/low_stock_alert_entity.dart';
import '../entities/message_response_entity.dart';
import '../entities/stock_movement_entity.dart';
import '../entities/update_inventory_category_request_entity.dart';
import '../entities/update_inventory_item_request_entity.dart';

abstract class InventoryRepository {
  Future<Either<AppFailure, List<InventoryItemListEntity>>>
  fetchInventoryItems({String? search, String? categoryId});

  Future<Either<AppFailure, InventoryItemDetailsEntity>>
  fetchInventoryItemDetails(String id);

  Future<Either<AppFailure, String>> createInventoryItem(
    CreateInventoryItemRequestEntity request,
  );

  Future<Either<AppFailure, bool>> updateInventoryItem(
    String id,
    UpdateInventoryItemRequestEntity request,
  );

  Future<Either<AppFailure, bool>> deactivateInventoryItem(String id);

  Future<Either<AppFailure, bool>> createStockMovement(
    String itemId,
    CreateStockMovementRequestEntity request,
  );

  Future<Either<AppFailure, List<StockMovementEntity>>> fetchStockMovements(
    String itemId,
  );

  Future<Either<AppFailure, List<InventoryCategoryListEntity>>>
  fetchInventoryCategories();

  Future<Either<AppFailure, String>> createInventoryCategory(
    CreateInventoryCategoryRequestEntity request,
  );

  Future<Either<AppFailure, MessageResponseEntity>> updateInventoryCategory(
    String id,
    UpdateInventoryCategoryRequestEntity request,
  );

  Future<Either<AppFailure, List<LowStockAlertEntity>>> fetchLowStockAlerts();
}
