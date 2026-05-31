import 'package:equatable/equatable.dart';

class UpdateInventoryItemRequestEntity extends Equatable {
  const UpdateInventoryItemRequestEntity({
    required this.categoryId,
    required this.itemName,
    required this.unitOfMeasure,
    required this.minimumQuantity,
    required this.costPerUnit,
  });

  final String categoryId;
  final String itemName;
  final String unitOfMeasure;
  final double minimumQuantity;
  final double costPerUnit;

  @override
  List<Object?> get props => [
    categoryId,
    itemName,
    unitOfMeasure,
    minimumQuantity,
    costPerUnit,
  ];
}
