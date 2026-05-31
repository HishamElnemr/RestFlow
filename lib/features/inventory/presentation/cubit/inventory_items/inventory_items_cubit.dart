import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_inventory_item_request_entity.dart';
import '../../../domain/entities/update_inventory_item_request_entity.dart';
import '../../../domain/repositories/inventory_repository.dart';
import 'inventory_items_state.dart';

class InventoryItemsCubit extends Cubit<InventoryItemsState> {
  InventoryItemsCubit(this._repository) : super(const InventoryItemsInitial());

  final InventoryRepository _repository;

  Future<void> fetchInventoryItems({String? search, String? categoryId}) async {
    emit(const InventoryItemsLoading(InventoryItemsAction.fetchList));
    final result = await _repository.fetchInventoryItems(
      search: search,
      categoryId: categoryId,
    );
    result.fold(
      (failure) =>
          emit(InventoryItemsFailure(failure, InventoryItemsAction.fetchList)),
      (items) => emit(InventoryItemsListSuccess(items)),
    );
  }

  Future<void> fetchInventoryItemDetails(String id) async {
    emit(const InventoryItemsLoading(InventoryItemsAction.fetchDetails));
    final result = await _repository.fetchInventoryItemDetails(id);
    result.fold(
      (failure) => emit(
        InventoryItemsFailure(failure, InventoryItemsAction.fetchDetails),
      ),
      (item) => emit(InventoryItemDetailsSuccess(item)),
    );
  }

  Future<void> createInventoryItem(
    CreateInventoryItemRequestEntity request,
  ) async {
    emit(const InventoryItemsLoading(InventoryItemsAction.create));
    final result = await _repository.createInventoryItem(request);
    result.fold(
      (failure) =>
          emit(InventoryItemsFailure(failure, InventoryItemsAction.create)),
      (id) => emit(
        InventoryItemsActionSuccess(InventoryItemsAction.create, id: id),
      ),
    );
  }

  Future<void> updateInventoryItem(
    String id,
    UpdateInventoryItemRequestEntity request,
  ) async {
    emit(const InventoryItemsLoading(InventoryItemsAction.update));
    final result = await _repository.updateInventoryItem(id, request);
    result.fold(
      (failure) =>
          emit(InventoryItemsFailure(failure, InventoryItemsAction.update)),
      (_) =>
          emit(const InventoryItemsActionSuccess(InventoryItemsAction.update)),
    );
  }

  Future<void> deactivateInventoryItem(String id) async {
    emit(const InventoryItemsLoading(InventoryItemsAction.deactivate));
    final result = await _repository.deactivateInventoryItem(id);
    result.fold(
      (failure) =>
          emit(InventoryItemsFailure(failure, InventoryItemsAction.deactivate)),
      (_) => emit(
        const InventoryItemsActionSuccess(InventoryItemsAction.deactivate),
      ),
    );
  }

  void reset() {
    emit(const InventoryItemsInitial());
  }
}
