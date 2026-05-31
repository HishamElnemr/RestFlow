import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_stock_movement_request_entity.dart';
import '../../../domain/repositories/inventory_repository.dart';
import 'stock_movements_state.dart';

class StockMovementsCubit extends Cubit<StockMovementsState> {
  StockMovementsCubit(this._repository)
      : super(const StockMovementsInitial());

  final InventoryRepository _repository;

  Future<void> fetchHistory(String itemId) async {
    emit(const StockMovementsLoading(StockMovementsAction.fetchHistory));
    final result = await _repository.fetchStockMovements(itemId);
    result.fold(
      (failure) => emit(
        StockMovementsFailure(failure, StockMovementsAction.fetchHistory),
      ),
      (movements) => emit(StockMovementsHistorySuccess(movements)),
    );
  }

  Future<void> createMovement(
    String itemId,
    CreateStockMovementRequestEntity request,
  ) async {
    emit(const StockMovementsLoading(StockMovementsAction.create));
    final result = await _repository.createStockMovement(itemId, request);
    result.fold(
      (failure) => emit(
        StockMovementsFailure(failure, StockMovementsAction.create),
      ),
      (_) => emit(const StockMovementsActionSuccess(StockMovementsAction.create)),
    );
  }

  void reset() {
    emit(const StockMovementsInitial());
  }
}
