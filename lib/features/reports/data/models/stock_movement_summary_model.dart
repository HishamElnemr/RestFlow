import '../../domain/entities/stock_movement_summary_entity.dart';

class StockMovementSummaryModel extends StockMovementSummaryEntity {
  const StockMovementSummaryModel({
    required super.inventoryItemId,
    required super.itemName,
    required super.unitOfMeasure,
    required super.totalStockIn,
    required super.totalStockOut,
    required super.totalAdjustments,
  });

  factory StockMovementSummaryModel.fromJson(Map<String, dynamic> json) {
    return StockMovementSummaryModel(
      inventoryItemId: json['inventoryItemId'] as String,
      itemName: json['itemName'] as String,
      unitOfMeasure: json['unitOfMeasure'] as String,
      totalStockIn: (json['totalStockIn'] as num).toDouble(),
      totalStockOut: (json['totalStockOut'] as num).toDouble(),
      totalAdjustments: (json['totalAdjustments'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventoryItemId': inventoryItemId,
      'itemName': itemName,
      'unitOfMeasure': unitOfMeasure,
      'totalStockIn': totalStockIn,
      'totalStockOut': totalStockOut,
      'totalAdjustments': totalAdjustments,
    };
  }

  StockMovementSummaryEntity toEntity() {
    return StockMovementSummaryEntity(
      inventoryItemId: inventoryItemId,
      itemName: itemName,
      unitOfMeasure: unitOfMeasure,
      totalStockIn: totalStockIn,
      totalStockOut: totalStockOut,
      totalAdjustments: totalAdjustments,
    );
  }
}
