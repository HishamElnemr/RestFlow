import 'package:equatable/equatable.dart';

import 'transaction_type.dart';

class StockMovementResponseEntity extends Equatable {
  const StockMovementResponseEntity({
    required this.id,
    required this.inventoryItemId,
    required this.inventoryItemName,
    required this.transactionType,
    required this.quantity,
    this.note,
    required this.transactionDate,
  });

  final String id;
  final String inventoryItemId;
  final String inventoryItemName;
  final TransactionType transactionType;
  final double quantity;
  final String? note;
  final DateTime transactionDate;

  @override
  List<Object?> get props => [
    id,
    inventoryItemId,
    inventoryItemName,
    transactionType,
    quantity,
    note,
    transactionDate,
  ];
}
