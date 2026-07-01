import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/menu_api_service.dart';
import '../../domain/entities/add_product_ingredient_request_entity.dart';
import '../../domain/entities/create_menu_category_request_entity.dart';
import '../../domain/entities/create_product_request_entity.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/product_ingredient_entity.dart';
import '../../domain/entities/product_list_entity.dart';
import '../../domain/entities/update_product_ingredient_request_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../models/add_product_ingredient_request_model.dart';
import '../models/create_menu_category_request_model.dart';
import '../models/create_product_request_model.dart';
import '../models/product_creation_response_model.dart';
import '../models/product_details_model.dart';
import '../models/product_ingredient_model.dart';
import '../models/update_product_ingredient_request_model.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({MenuApiService? apiService})
      : _apiService = apiService ?? MenuApiService(Dio());

  final MenuApiService _apiService;

  // ── Menu Categories ───────────────────────────────────────────────────────

  @override
  Future<Either<AppFailure, List<MenuCategoryListEntity>>>
  getMenuCategories() async {
    try {
      final List<MenuCategoryListEntity> response =
          await _apiService.getMenuCategories();
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, String>> createMenuCategory(
    CreateMenuCategoryRequestEntity request,
  ) async {
    try {
      final id = await _apiService.createMenuCategory(
        CreateMenuCategoryRequestModel.fromEntity(request),
      );
      return Right(id);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> updateMenuCategory(
    String id,
    CreateMenuCategoryRequestEntity request,
  ) async {
    try {
      await _apiService.updateMenuCategory(
        id,
        CreateMenuCategoryRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  // ── Products ──────────────────────────────────────────────────────────────

  @override
  Future<Either<AppFailure, List<ProductListEntity>>> getProducts({
    String? search,
    String? categoryId,
  }) async {
    try {
      final List<ProductListEntity> response = await _apiService.getProducts(
        search,
        categoryId,
      );
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, ProductDetailsEntity>> getProductDetails(
    String id,
  ) async {
    try {
      final ProductDetailsModel response =
          await _apiService.getProductDetails(id);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, String>> createProduct(
    CreateProductRequestEntity request,
  ) async {
    try {
      final ProductCreationResponseModel response =
          await _apiService.createProduct(
        CreateProductRequestModel.fromEntity(request),
      );
      return Right(response.productId);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> updateProduct(
    String id,
    CreateProductRequestEntity request,
  ) async {
    try {
      await _apiService.updateProduct(
        id,
        CreateProductRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> changeProductAvailability(
    String id, {
    required bool isAvailable,
  }) async {
    try {
      await _apiService.changeProductAvailability(
        id,
        {'isAvailable': isAvailable},
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  // ── Product Ingredients ───────────────────────────────────────────────────

  @override
  Future<Either<AppFailure, List<ProductIngredientEntity>>>
  getProductIngredients(String productId) async {
    try {
      final List<ProductIngredientModel> response =
          await _apiService.getProductIngredients(productId);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> addProductIngredient(
    AddProductIngredientRequestEntity request,
  ) async {
    try {
      await _apiService.addProductIngredient(
        AddProductIngredientRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> updateProductIngredient(
    String productId,
    String ingredientId,
    UpdateProductIngredientRequestEntity request,
  ) async {
    try {
      await _apiService.updateProductIngredient(
        productId,
        ingredientId,
        UpdateProductIngredientRequestModel.fromEntity(request),
      );
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, bool>> deleteProductIngredient(String id) async {
    try {
      await _apiService.deleteProductIngredient(id);
      return const Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
