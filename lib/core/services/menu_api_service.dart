import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/menu/data/models/add_product_ingredient_request_model.dart';
import '../../features/menu/data/models/create_menu_category_request_model.dart';
import '../../features/menu/data/models/create_product_request_model.dart';
import '../../features/menu/data/models/menu_category_list_model.dart';
import '../../features/menu/data/models/product_creation_response_model.dart';
import '../../features/menu/data/models/product_details_model.dart';
import '../../features/menu/data/models/product_ingredient_model.dart';
import '../../features/menu/data/models/product_list_model.dart';
import '../../features/menu/data/models/update_product_ingredient_request_model.dart';
import '../constants/api_constants.dart';

part 'menu_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MenuApiService {
  factory MenuApiService(Dio dio, {String baseUrl}) = _MenuApiService;

  // ── Menu Categories ───────────────────────────────────────────────────────

  @GET('/api/menu/categories')
  Future<List<MenuCategoryListModel>> getMenuCategories();

  @POST('/api/menu/categories')
  Future<String> createMenuCategory(
    @Body() CreateMenuCategoryRequestModel body,
  );

  @PATCH('/api/menu/categories/{id}')
  Future<void> updateMenuCategory(
    @Path('id') String id,
    @Body() CreateMenuCategoryRequestModel body,
  );

  // ── Products ──────────────────────────────────────────────────────────────
  // NOTE: Backend ProductsController uses route "menu/products" (no api/ prefix)

  @GET('/menu/products')
  Future<List<ProductListModel>> getProducts(
    @Query('search') String? search,
    @Query('categoryId') String? categoryId,
  );

  @GET('/menu/products/{id}')
  Future<ProductDetailsModel> getProductDetails(@Path('id') String id);

  @POST('/menu/products')
  Future<ProductCreationResponseModel> createProduct(
    @Body() CreateProductRequestModel body,
  );

  @PUT('/menu/products/{id}')
  Future<void> updateProduct(
    @Path('id') String id,
    @Body() CreateProductRequestModel body,
  );

  @PATCH('/menu/products/{id}/availability')
  Future<void> changeProductAvailability(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  // ── Product Ingredients ───────────────────────────────────────────────────

  @GET('/api/product-ingredients/menu/products/{id}/ingredients')
  Future<List<ProductIngredientModel>> getProductIngredients(
    @Path('id') String id,
  );

  @POST('/api/product-ingredients')
  Future<void> addProductIngredient(
    @Body() AddProductIngredientRequestModel body,
  );

  @PATCH('/api/product-ingredients/menu/products/{productId}/ingredients/{ingredientId}')
  Future<void> updateProductIngredient(
    @Path('productId') String productId,
    @Path('ingredientId') String ingredientId,
    @Body() UpdateProductIngredientRequestModel body,
  );

  @DELETE('/api/product-ingredients/{id}')
  Future<void> deleteProductIngredient(@Path('id') String id);
}
