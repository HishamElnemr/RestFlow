import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/stock_movement_entity.dart';

enum StockMovementsAction { fetchHistory, create }

abstract class StockMovementsState extends Equatable {
  const StockMovementsState();

  @override
  List<Object?> get props => [];
}

class StockMovementsInitial extends StockMovementsState {
  const StockMovementsInitial();
}

class StockMovementsLoading extends StockMovementsState {
  const StockMovementsLoading(this.action);

  final StockMovementsAction action;

  @override
  List<Object?> get props => [action];
}

class StockMovementsHistorySuccess extends StockMovementsState {
  const StockMovementsHistorySuccess(this.movements);

  final List<StockMovementEntity> movements;

  @override
  List<Object?> get props => [movements];
}

class StockMovementsActionSuccess extends StockMovementsState {
  const StockMovementsActionSuccess(this.action);

  final StockMovementsAction action;

  @override
  List<Object?> get props => [action];
}

class StockMovementsFailure extends StockMovementsState {
  const StockMovementsFailure(this.failure, this.action);

  final AppFailure failure;
  final StockMovementsAction action;

  @override
  List<Object?> get props => [failure, action];
}
