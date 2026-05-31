import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/inventory/data/models/create_inventory_category_request_model.dart';
import '../../features/inventory/data/models/create_inventory_item_request_model.dart';
import '../../features/inventory/data/models/create_stock_movement_request_model.dart';
import '../../features/inventory/data/models/inventory_category_list_model.dart';
import '../../features/inventory/data/models/inventory_item_details_model.dart';
import '../../features/inventory/data/models/inventory_item_list_model.dart';
import '../../features/inventory/data/models/low_stock_alert_model.dart';
import '../../features/inventory/data/models/message_response_model.dart';
import '../../features/inventory/data/models/stock_movement_model.dart';
import '../../features/inventory/data/models/update_inventory_category_request_model.dart';
import '../../features/inventory/data/models/update_inventory_item_request_model.dart';
import '../constants/api_constants.dart';

part 'inventory_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class InventoryApiService {
  factory InventoryApiService(Dio dio, {String baseUrl}) = _InventoryApiService;

  @GET('/inventory/items')
  Future<List<InventoryItemListModel>> fetchInventoryItems(
    @Query('search') String? search,
    @Query('categoryId') String? categoryId,
  );

  @GET('/inventory/items/{id}')
  Future<InventoryItemDetailsModel> fetchInventoryItemDetails(
    @Path('id') String id,
  );

  @POST('/inventory/items')
  Future<String> createInventoryItem(
    @Body() CreateInventoryItemRequestModel request,
  );

  @PATCH('/inventory/items/{id}')
  Future<void> updateInventoryItem(
    @Path('id') String id,
    @Body() UpdateInventoryItemRequestModel request,
  );

  @PATCH('/inventory/items/{id}/deactivate')
  Future<void> deactivateInventoryItem(@Path('id') String id);

  @POST('/inventory/items/{id}/transactions')
  Future<void> createStockMovement(
    @Path('id') String id,
    @Body() CreateStockMovementRequestModel request,
  );

  @GET('/inventory/items/{id}/transactions')
  Future<List<StockMovementModel>> fetchStockMovements(@Path('id') String id);

  @GET('/api/inventory-categories')
  Future<List<InventoryCategoryListModel>> fetchInventoryCategories();

  @POST('/api/inventory-categories')
  Future<String> createInventoryCategory(
    @Body() CreateInventoryCategoryRequestModel request,
  );

  @PUT('/api/inventory-categories/{id}')
  Future<MessageResponseModel> updateInventoryCategory(
    @Path('id') String id,
    @Body() UpdateInventoryCategoryRequestModel request,
  );

  @GET('/api/InventoryAlerts/alerts/low-stock')
  Future<List<LowStockAlertModel>> fetchLowStockAlerts();
}
