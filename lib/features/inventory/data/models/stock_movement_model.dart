import '../../domain/entities/stock_movement_entity.dart';
import 'inventory_parsers.dart';
import 'transaction_type_mapper.dart';

class StockMovementModel extends StockMovementEntity {
  const StockMovementModel({
    required super.id,
    required super.transactionType,
    required super.quantity,
    super.note,
    required super.transactionDate,
    super.createdBy,
  });

  factory StockMovementModel.fromEntity(StockMovementEntity entity) {
    return StockMovementModel(
      id: entity.id,
      transactionType: entity.transactionType,
      quantity: entity.quantity,
      note: entity.note,
      transactionDate: entity.transactionDate,
      createdBy: entity.createdBy,
    );
  }

  StockMovementEntity toEntity() {
    return StockMovementEntity(
      id: id,
      transactionType: transactionType,
      quantity: quantity,
      note: note,
      transactionDate: transactionDate,
      createdBy: createdBy,
    );
  }

  factory StockMovementModel.fromJson(Map<String, dynamic> json) {
    return StockMovementModel(
      id: (json['id'] ?? '').toString(),
      transactionType: parseTransactionType(json['transactionType']),
      quantity: parseDouble(json['quantity']),
      note: json['note']?.toString(),
      transactionDate: parseDateTime(json['transactionDate']) ?? DateTime.now(),
      createdBy: json['createdBy']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'transactionType': transactionTypeToJson(transactionType),
    'quantity': quantity,
    'note': note,
    'transactionDate': transactionDate.toIso8601String(),
    'createdBy': createdBy,
  };
}
