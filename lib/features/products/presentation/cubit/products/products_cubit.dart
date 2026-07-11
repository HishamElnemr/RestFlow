import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/domain/entities/create_product_request_entity.dart';
import 'package:rest_flow/features/products/domain/repositories/products_repository.dart';

import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repository) : super(const ProductsInitial());

  final ProductsRepository _repository;

  Future<void> fetchProducts({String? search, String? categoryId}) async {
    log('[ProductsCubit] fetchProducts called (search=$search, categoryId=$categoryId)');
    emit(const ProductsLoading(ProductsAction.fetchAll));
    final result = await _repository.getProducts(search: search, categoryId: categoryId);
    result.fold(
      (failure) {
        log('[ProductsCubit] fetchProducts FAILED: ${failure.message}');
        emit(ProductsFailure(failure, ProductsAction.fetchAll));
      },
      (products) {
        log('[ProductsCubit] fetchProducts SUCCESS: ${products.length} products');
        emit(ProductsListLoaded(products));
      },
    );
  }

  Future<void> fetchProductDetails(String id) async {
    log('[ProductsCubit] fetchProductDetails called (id=$id)');
    emit(const ProductsLoading(ProductsAction.fetchDetails));
    final result = await _repository.getProductDetails(id);
    result.fold(
      (failure) {
        log('[ProductsCubit] fetchProductDetails FAILED: ${failure.message}');
        emit(ProductsFailure(failure, ProductsAction.fetchDetails));
      },
      (product) {
        log('[ProductsCubit] fetchProductDetails SUCCESS: ${product.productName}');
        emit(ProductDetailsLoaded(product));
      },
    );
  }

  Future<void> createProduct(CreateProductRequestEntity request) async {
    log('[ProductsCubit] createProduct called (name=${request.productName})');
    emit(const ProductsLoading(ProductsAction.create));
    final result = await _repository.createProduct(request);
    result.fold(
      (failure) {
        log('[ProductsCubit] createProduct FAILED: ${failure.message}');
        emit(ProductsFailure(failure, ProductsAction.create));
      },
      (newId) {
        log('[ProductsCubit] createProduct SUCCESS: newId=$newId');
        emit(ProductActionSuccess(ProductsAction.create, newProductId: newId));
      },
    );
  }

  Future<void> updateProduct(String id, CreateProductRequestEntity request) async {
    log('[ProductsCubit] updateProduct called (id=$id, name=${request.productName})');
    emit(const ProductsLoading(ProductsAction.update));
    final result = await _repository.updateProduct(id, request);
    result.fold(
      (failure) {
        log('[ProductsCubit] updateProduct FAILED: ${failure.message}');
        emit(ProductsFailure(failure, ProductsAction.update));
      },
      (_) {
        log('[ProductsCubit] updateProduct SUCCESS');
        emit(const ProductActionSuccess(ProductsAction.update));
      },
    );
  }

  Future<void> changeProductAvailability(String id, bool isAvailable) async {
    log('[ProductsCubit] changeAvailability called (id=$id, isAvailable=$isAvailable)');
    emit(const ProductsLoading(ProductsAction.changeAvailability));
    final result = await _repository.changeProductAvailability(id, isAvailable);
    result.fold(
      (failure) {
        log('[ProductsCubit] changeAvailability FAILED: ${failure.message}');
        emit(ProductsFailure(failure, ProductsAction.changeAvailability));
      },
      (_) {
        log('[ProductsCubit] changeAvailability SUCCESS');
        emit(const ProductActionSuccess(ProductsAction.changeAvailability));
      },
    );
  }

  void reset() => emit(const ProductsInitial());
}
