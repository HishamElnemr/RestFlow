import '../../domain/entities/stock_movement_response_entity.dart';
import 'inventory_parsers.dart';
import 'transaction_type_mapper.dart';

class StockMovementResponseModel extends StockMovementResponseEntity {
  const StockMovementResponseModel({
    required super.id,
    required super.inventoryItemId,
    required super.inventoryItemName,
    required super.transactionType,
    required super.quantity,
    super.note,
    required super.transactionDate,
  });

  factory StockMovementResponseModel.fromEntity(
    StockMovementResponseEntity entity,
  ) {
    return StockMovementResponseModel(
      id: entity.id,
      inventoryItemId: entity.inventoryItemId,
      inventoryItemName: entity.inventoryItemName,
      transactionType: entity.transactionType,
      quantity: entity.quantity,
      note: entity.note,
      transactionDate: entity.transactionDate,
    );
  }

  StockMovementResponseEntity toEntity() {
    return StockMovementResponseEntity(
      id: id,
      inventoryItemId: inventoryItemId,
      inventoryItemName: inventoryItemName,
      transactionType: transactionType,
      quantity: quantity,
      note: note,
      transactionDate: transactionDate,
    );
  }

  factory StockMovementResponseModel.fromJson(Map<String, dynamic> json) {
    return StockMovementResponseModel(
      id: (json['id'] ?? '').toString(),
      inventoryItemId: (json['inventoryItemId'] ?? '').toString(),
      inventoryItemName: (json['inventoryItemName'] ?? '').toString(),
      transactionType: parseTransactionType(json['transactionType']),
      quantity: parseDouble(json['quantity']),
      note: json['note']?.toString(),
      transactionDate: parseDateTime(json['transactionDate']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'inventoryItemId': inventoryItemId,
    'inventoryItemName': inventoryItemName,
    'transactionType': transactionTypeToJson(transactionType),
    'quantity': quantity,
    'note': note,
    'transactionDate': transactionDate.toIso8601String(),
  };
}
