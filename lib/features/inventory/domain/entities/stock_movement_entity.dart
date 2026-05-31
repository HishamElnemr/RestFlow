import 'package:equatable/equatable.dart';

import 'transaction_type.dart';

class StockMovementEntity extends Equatable {
  const StockMovementEntity({
    required this.id,
    required this.transactionType,
    required this.quantity,
    this.note,
    required this.transactionDate,
    this.createdBy,
  });

  final String id;
  final TransactionType transactionType;
  final double quantity;
  final String? note;
  final DateTime transactionDate;
  final String? createdBy;

  @override
  List<Object?> get props => [
    id,
    transactionType,
    quantity,
    note,
    transactionDate,
    createdBy,
  ];
}
