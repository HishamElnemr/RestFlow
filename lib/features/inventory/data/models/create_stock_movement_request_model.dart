import '../../domain/entities/create_stock_movement_request_entity.dart';
import 'inventory_parsers.dart';
import 'transaction_type_mapper.dart';

class CreateStockMovementRequestModel extends CreateStockMovementRequestEntity {
  const CreateStockMovementRequestModel({
    required super.transactionType,
    required super.quantity,
    super.note,
  });

  factory CreateStockMovementRequestModel.fromEntity(
    CreateStockMovementRequestEntity entity,
  ) {
    return CreateStockMovementRequestModel(
      transactionType: entity.transactionType,
      quantity: entity.quantity,
      note: entity.note,
    );
  }

  factory CreateStockMovementRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateStockMovementRequestModel(
      transactionType: parseTransactionType(json['transactionType']),
      quantity: parseDouble(json['quantity']),
      note: json['note']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'transactionType': transactionTypeToJson(transactionType),
    'quantity': quantity,
    'note': note,
  };
}
