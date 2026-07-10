import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../menu/domain/entities/create_product_request_entity.dart';
import '../../../menu/domain/entities/product_details_entity.dart';
import '../../../menu/domain/entities/product_list_entity.dart';

abstract class ProductsRepository {
  Future<Either<AppFailure, List<ProductListEntity>>> getProducts({
    String? search,
    String? categoryId,
  });

  Future<Either<AppFailure, ProductDetailsEntity>> getProductDetails(String id);

  Future<Either<AppFailure, String>> createProduct(
    CreateProductRequestEntity request,
  );

  Future<Either<AppFailure, void>> updateProduct(
    String id,
    CreateProductRequestEntity request,
  );

  Future<Either<AppFailure, void>> changeProductAvailability(
    String id,
    bool isAvailable,
  );
}
