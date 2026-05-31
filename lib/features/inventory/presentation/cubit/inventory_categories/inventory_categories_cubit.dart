import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_inventory_category_request_entity.dart';
import '../../../domain/entities/update_inventory_category_request_entity.dart';
import '../../../domain/repositories/inventory_repository.dart';
import 'inventory_categories_state.dart';

class InventoryCategoriesCubit extends Cubit<InventoryCategoriesState> {
  InventoryCategoriesCubit(this._repository)
      : super(const InventoryCategoriesInitial());

  final InventoryRepository _repository;

  Future<void> fetchCategories() async {
    emit(const InventoryCategoriesLoading(InventoryCategoriesAction.fetchList));
    final result = await _repository.fetchInventoryCategories();
    result.fold(
      (failure) => emit(
        InventoryCategoriesFailure(
          failure,
          InventoryCategoriesAction.fetchList,
        ),
      ),
      (categories) => emit(InventoryCategoriesListSuccess(categories)),
    );
  }

  Future<void> createCategory(
    CreateInventoryCategoryRequestEntity request,
  ) async {
    emit(const InventoryCategoriesLoading(InventoryCategoriesAction.create));
    final result = await _repository.createInventoryCategory(request);
    result.fold(
      (failure) => emit(
        InventoryCategoriesFailure(
          failure,
          InventoryCategoriesAction.create,
        ),
      ),
      (id) => emit(
        InventoryCategoriesActionSuccess(
          InventoryCategoriesAction.create,
          id: id,
        ),
      ),
    );
  }

  Future<void> updateCategory(
    String id,
    UpdateInventoryCategoryRequestEntity request,
  ) async {
    emit(const InventoryCategoriesLoading(InventoryCategoriesAction.update));
    final result = await _repository.updateInventoryCategory(id, request);
    result.fold(
      (failure) => emit(
        InventoryCategoriesFailure(
          failure,
          InventoryCategoriesAction.update,
        ),
      ),
      (response) => emit(
        InventoryCategoriesActionSuccess(
          InventoryCategoriesAction.update,
          message: response.message,
        ),
      ),
    );
  }

  void reset() {
    emit(const InventoryCategoriesInitial());
  }
}
