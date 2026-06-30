import '../../domain/entities/inventory_consumption_entity.dart';
import 'ingredient_consumption_model.dart';
import 'stock_movement_summary_model.dart';

class InventoryConsumptionModel extends InventoryConsumptionEntity {
  const InventoryConsumptionModel({
    required List<IngredientConsumptionModel> mostConsumedIngredients,
    required List<StockMovementSummaryModel> stockMovementSummaries,
  }) : super(
         mostConsumedIngredients: mostConsumedIngredients,
         stockMovementSummaries: stockMovementSummaries,
       );

  factory InventoryConsumptionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ingredientsList =
        json['mostConsumedIngredients'] as List<dynamic>? ?? [];
    final List<dynamic> movementsList =
        json['stockMovementSummaries'] as List<dynamic>? ?? [];

    return InventoryConsumptionModel(
      mostConsumedIngredients: ingredientsList
          .map(
            (e) => IngredientConsumptionModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      stockMovementSummaries: movementsList
          .map(
            (e) => StockMovementSummaryModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mostConsumedIngredients': mostConsumedIngredients
          .map((e) => (e as IngredientConsumptionModel).toJson())
          .toList(),
      'stockMovementSummaries': stockMovementSummaries
          .map((e) => (e as StockMovementSummaryModel).toJson())
          .toList(),
    };
  }

  InventoryConsumptionEntity toEntity() => this;
}
