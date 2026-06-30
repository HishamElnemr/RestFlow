import 'package:equatable/equatable.dart';

class StockMovementSummaryEntity extends Equatable {
  const StockMovementSummaryEntity({
    required this.inventoryItemId,
    required this.itemName,
    required this.unitOfMeasure,
    required this.totalStockIn,
    required this.totalStockOut,
    required this.totalAdjustments,
  });

  final String inventoryItemId;
  final String itemName;
  final String unitOfMeasure;
  final double totalStockIn;
  final double totalStockOut;
  final double totalAdjustments;

  @override
  List<Object?> get props => [
    inventoryItemId,
    itemName,
    unitOfMeasure,
    totalStockIn,
    totalStockOut,
    totalAdjustments,
  ];
}
