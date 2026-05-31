import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/inventory_repository.dart';
import 'low_stock_state.dart';

class LowStockCubit extends Cubit<LowStockState> {
  LowStockCubit(this._repository) : super(const LowStockInitial());

  final InventoryRepository _repository;

  Future<void> fetchLowStockAlerts() async {
    emit(const LowStockLoading());
    final result = await _repository.fetchLowStockAlerts();
    result.fold(
      (failure) => emit(LowStockFailure(failure)),
      (alerts) => emit(LowStockSuccess(alerts)),
    );
  }

  void reset() {
    emit(const LowStockInitial());
  }
}
