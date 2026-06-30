import 'package:equatable/equatable.dart';

import 'ingredient_consumption_entity.dart';
import 'stock_movement_summary_entity.dart';

class InventoryConsumptionEntity extends Equatable {
  const InventoryConsumptionEntity({
    required this.mostConsumedIngredients,
    required this.stockMovementSummaries,
  });

  final List<IngredientConsumptionEntity> mostConsumedIngredients;
  final List<StockMovementSummaryEntity> stockMovementSummaries;

  @override
  List<Object?> get props => [mostConsumedIngredients, stockMovementSummaries];
}
