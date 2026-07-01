import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/add_product_ingredient_request_entity.dart';
import '../entities/create_menu_category_request_entity.dart';
import '../entities/create_product_request_entity.dart';
import '../entities/menu_category_list_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/product_ingredient_entity.dart';
import '../entities/product_list_entity.dart';
import '../entities/update_product_ingredient_request_entity.dart';

abstract class MenuRepository {
  // ── Menu Categories ───────────────────────────────────────────────────────

  Future<Either<AppFailure, List<MenuCategoryListEntity>>> getMenuCategories();

  Future<Either<AppFailure, String>> createMenuCategory(
    CreateMenuCategoryRequestEntity request,
  );

  Future<Either<AppFailure, bool>> updateMenuCategory(
    String id,
    CreateMenuCategoryRequestEntity request,
  );

  // ── Products ──────────────────────────────────────────────────────────────

  Future<Either<AppFailure, List<ProductListEntity>>> getProducts({
    String? search,
    String? categoryId,
  });

  Future<Either<AppFailure, ProductDetailsEntity>> getProductDetails(String id);

  Future<Either<AppFailure, String>> createProduct(
    CreateProductRequestEntity request,
  );

  Future<Either<AppFailure, bool>> updateProduct(
    String id,
    CreateProductRequestEntity request,
  );

  Future<Either<AppFailure, bool>> changeProductAvailability(
    String id, {
    required bool isAvailable,
  });

  // ── Product Ingredients ───────────────────────────────────────────────────

  Future<Either<AppFailure, List<ProductIngredientEntity>>>
  getProductIngredients(String productId);

  Future<Either<AppFailure, bool>> addProductIngredient(
    AddProductIngredientRequestEntity request,
  );

  Future<Either<AppFailure, bool>> updateProductIngredient(
    String productId,
    String ingredientId,
    UpdateProductIngredientRequestEntity request,
  );

  Future<Either<AppFailure, bool>> deleteProductIngredient(String id);
}
