import 'package:equatable/equatable.dart';

class LowStockAlertEntity extends Equatable {
  const LowStockAlertEntity({
    required this.id,
    required this.itemName,
    required this.categoryName,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.unitOfMeasure,
  });

  final String id;
  final String itemName;
  final String categoryName;
  final double currentQuantity;
  final double minimumQuantity;
  final String unitOfMeasure;

  @override
  List<Object?> get props => [
    id,
    itemName,
    categoryName,
    currentQuantity,
    minimumQuantity,
    unitOfMeasure,
  ];
}
