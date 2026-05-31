import 'package:equatable/equatable.dart';

class CreateInventoryItemRequestEntity extends Equatable {
  const CreateInventoryItemRequestEntity({
    required this.itemName,
    required this.categoryId,
    required this.unitOfMeasure,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.costPerUnit,
  });

  final String itemName;
  final String categoryId;
  final String unitOfMeasure;
  final double currentQuantity;
  final double minimumQuantity;
  final double costPerUnit;

  @override
  List<Object?> get props => [
    itemName,
    categoryId,
    unitOfMeasure,
    currentQuantity,
    minimumQuantity,
    costPerUnit,
  ];
}
