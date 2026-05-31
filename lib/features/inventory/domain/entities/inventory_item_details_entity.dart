import 'package:equatable/equatable.dart';

class InventoryItemDetailsEntity extends Equatable {
  const InventoryItemDetailsEntity({
    required this.id,
    required this.itemName,
    required this.categoryName,
    required this.unitOfMeasure,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.costPerUnit,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String itemName;
  final String categoryName;
  final String unitOfMeasure;
  final double currentQuantity;
  final double minimumQuantity;
  final double costPerUnit;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    itemName,
    categoryName,
    unitOfMeasure,
    currentQuantity,
    minimumQuantity,
    costPerUnit,
    createdAt,
    updatedAt,
  ];
}
