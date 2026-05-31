import 'package:equatable/equatable.dart';

class InventoryItemResponseEntity extends Equatable {
  const InventoryItemResponseEntity({
    required this.id,
    required this.itemName,
    required this.categoryName,
    required this.unitOfMeasure,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.costPerUnit,
    required this.isLowStock,
    required this.isActive,
  });

  final String id;
  final String itemName;
  final String categoryName;
  final String unitOfMeasure;
  final double currentQuantity;
  final double minimumQuantity;
  final double costPerUnit;
  final bool isLowStock;
  final bool isActive;

  @override
  List<Object?> get props => [
    id,
    itemName,
    categoryName,
    unitOfMeasure,
    currentQuantity,
    minimumQuantity,
    costPerUnit,
    isLowStock,
    isActive,
  ];
}
