import 'package:equatable/equatable.dart';

class InventoryItemListEntity extends Equatable {
  const InventoryItemListEntity({
    required this.id,
    required this.itemName,
    required this.categoryName,
    required this.unitOfMeasure,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.costPerUnit,
    required this.isLowStock,
  });

  final String id;
  final String itemName;
  final String categoryName;
  final String unitOfMeasure;
  final double currentQuantity;
  final double minimumQuantity;
  final double costPerUnit;
  final bool isLowStock;

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
  ];
}
