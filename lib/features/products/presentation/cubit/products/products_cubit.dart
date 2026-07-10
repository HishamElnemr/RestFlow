import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/domain/entities/create_product_request_entity.dart';
import 'package:rest_flow/features/products/domain/repositories/products_repository.dart';


import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repository) : super(const ProductsInitial());

  final ProductsRepository _repository;

  Future<void> fetchProducts({String? search, String? categoryId}) async {
    emit(const ProductsLoading(ProductsAction.fetchAll));
    final result = await _repository.getProducts(search: search, categoryId: categoryId);
    result.fold(
      (failure) => emit(ProductsFailure(failure, ProductsAction.fetchAll)),
      (products) => emit(ProductsListLoaded(products)),
    );
  }

  Future<void> fetchProductDetails(String id) async {
    emit(const ProductsLoading(ProductsAction.fetchDetails));
    final result = await _repository.getProductDetails(id);
    result.fold(
      (failure) => emit(ProductsFailure(failure, ProductsAction.fetchDetails)),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }

  Future<void> createProduct(CreateProductRequestEntity request) async {
    emit(const ProductsLoading(ProductsAction.create));
    final result = await _repository.createProduct(request);
    result.fold(
      (failure) => emit(ProductsFailure(failure, ProductsAction.create)),
      (newId) => emit(ProductActionSuccess(ProductsAction.create, newProductId: newId)),
    );
  }

  Future<void> updateProduct(String id, CreateProductRequestEntity request) async {
    emit(const ProductsLoading(ProductsAction.update));
    final result = await _repository.updateProduct(id, request);
    result.fold(
      (failure) => emit(ProductsFailure(failure, ProductsAction.update)),
      (_) => emit(const ProductActionSuccess(ProductsAction.update)),
    );
  }

  Future<void> changeProductAvailability(String id, bool isAvailable) async {
    emit(const ProductsLoading(ProductsAction.changeAvailability));
    final result = await _repository.changeProductAvailability(id, isAvailable);
    result.fold(
      (failure) => emit(ProductsFailure(failure, ProductsAction.changeAvailability)),
      (_) => emit(const ProductActionSuccess(ProductsAction.changeAvailability)),
    );
  }

  void reset() => emit(const ProductsInitial());
}
