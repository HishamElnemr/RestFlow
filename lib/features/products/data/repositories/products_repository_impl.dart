import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../menu/domain/entities/create_product_request_entity.dart';
import '../../../menu/domain/entities/product_details_entity.dart';
import '../../../menu/domain/entities/product_list_entity.dart';
import '../../../menu/data/models/create_product_request_model.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppFailure, List<ProductListEntity>>> getProducts({
    String? search,
    String? categoryId,
  }) async {
    try {
      final result = await _remoteDataSource.getProducts(
        search: search,
        categoryId: categoryId,
      );
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, ProductDetailsEntity>> getProductDetails(String id) async {
    try {
      final result = await _remoteDataSource.getProductDetails(id);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, String>> createProduct(
    CreateProductRequestEntity request,
  ) async {
    try {
      final model = CreateProductRequestModel.fromEntity(request);
      final result = await _remoteDataSource.createProduct(model.toJson());
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateProduct(
    String id,
    CreateProductRequestEntity request,
  ) async {
    try {
      final model = CreateProductRequestModel.fromEntity(request);
      await _remoteDataSource.updateProduct(id, model.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> changeProductAvailability(
    String id,
    bool isAvailable,
  ) async {
    try {
      await _remoteDataSource.changeProductAvailability(id, isAvailable);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
