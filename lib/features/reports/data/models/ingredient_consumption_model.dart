import '../../domain/entities/ingredient_consumption_entity.dart';

class IngredientConsumptionModel extends IngredientConsumptionEntity {
  const IngredientConsumptionModel({
    required super.inventoryItemId,
    required super.itemName,
    required super.totalConsumption,
    required super.unitOfMeasure,
  });

  factory IngredientConsumptionModel.fromJson(Map<String, dynamic> json) {
    return IngredientConsumptionModel(
      inventoryItemId: json['inventoryItemId'] as String,
      itemName: json['itemName'] as String,
      totalConsumption: (json['totalConsumption'] as num).toDouble(),
      unitOfMeasure: json['unitOfMeasure'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventoryItemId': inventoryItemId,
      'itemName': itemName,
      'totalConsumption': totalConsumption,
      'unitOfMeasure': unitOfMeasure,
    };
  }

  IngredientConsumptionEntity toEntity() {
    return IngredientConsumptionEntity(
      inventoryItemId: inventoryItemId,
      itemName: itemName,
      totalConsumption: totalConsumption,
      unitOfMeasure: unitOfMeasure,
    );
  }
}
