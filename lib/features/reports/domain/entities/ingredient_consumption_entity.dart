import 'package:equatable/equatable.dart';

class IngredientConsumptionEntity extends Equatable {
  const IngredientConsumptionEntity({
    required this.inventoryItemId,
    required this.itemName,
    required this.totalConsumption,
    required this.unitOfMeasure,
  });

  final String inventoryItemId;
  final String itemName;
  final double totalConsumption;
  final String unitOfMeasure;

  @override
  List<Object?> get props => [
    inventoryItemId,
    itemName,
    totalConsumption,
    unitOfMeasure,
  ];
}
