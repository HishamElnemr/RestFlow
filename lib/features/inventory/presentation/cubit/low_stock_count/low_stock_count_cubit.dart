import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/inventory_repository.dart';
import 'low_stock_count_state.dart';

class LowStockCountCubit extends Cubit<LowStockCountState> {
  LowStockCountCubit(this._repository) : super(const LowStockCountInitial());

  final InventoryRepository _repository;

  Future<void> fetchLowStockCount() async {
    emit(const LowStockCountLoading());
    final result = await _repository.fetchLowStockAlerts();
    result.fold(
      (failure) => emit(LowStockCountFailure(failure)),
      (alerts) => emit(LowStockCountSuccess(alerts.length)),
    );
  }

  void reset() {
    emit(const LowStockCountInitial());
  }
}
