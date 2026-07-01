import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_product_request_entity.dart';
import '../../../domain/repositories/menu_repository.dart';
import 'menu_products_state.dart';

class MenuProductsCubit extends Cubit<MenuProductsState> {
  MenuProductsCubit(this._repository) : super(const MenuProductsInitial());

  final MenuRepository _repository;

  Future<void> fetchProducts({String? search, String? categoryId}) async {
    emit(const MenuProductsLoading(MenuProductsAction.fetchList));
    final result = await _repository.getProducts(
      search: search,
      categoryId: categoryId,
    );
    result.fold(
      (failure) =>
          emit(MenuProductsFailure(failure, MenuProductsAction.fetchList)),
      (products) => emit(MenuProductsListSuccess(products)),
    );
  }

  Future<void> fetchProductDetails(String id) async {
    emit(const MenuProductsLoading(MenuProductsAction.fetchDetails));
    final result = await _repository.getProductDetails(id);
    result.fold(
      (failure) =>
          emit(MenuProductsFailure(failure, MenuProductsAction.fetchDetails)),
      (product) => emit(MenuProductDetailsSuccess(product)),
    );
  }

  Future<void> createProduct(CreateProductRequestEntity request) async {
    emit(const MenuProductsLoading(MenuProductsAction.create));
    final result = await _repository.createProduct(request);
    result.fold(
      (failure) =>
          emit(MenuProductsFailure(failure, MenuProductsAction.create)),
      (productId) => emit(
        MenuProductsActionSuccess(MenuProductsAction.create, productId: productId),
      ),
    );
  }

  Future<void> updateProduct(
    String id,
    CreateProductRequestEntity request,
  ) async {
    emit(const MenuProductsLoading(MenuProductsAction.update));
    final result = await _repository.updateProduct(id, request);
    result.fold(
      (failure) =>
          emit(MenuProductsFailure(failure, MenuProductsAction.update)),
      (_) =>
          emit(const MenuProductsActionSuccess(MenuProductsAction.update)),
    );
  }

  Future<void> changeProductAvailability(
    String id, {
    required bool isAvailable,
  }) async {
    emit(const MenuProductsLoading(MenuProductsAction.changeAvailability));
    final result = await _repository.changeProductAvailability(
      id,
      isAvailable: isAvailable,
    );
    result.fold(
      (failure) => emit(
        MenuProductsFailure(failure, MenuProductsAction.changeAvailability),
      ),
      (_) => emit(
        const MenuProductsActionSuccess(MenuProductsAction.changeAvailability),
      ),
    );
  }

  void reset() => emit(const MenuProductsInitial());
}
