import 'package:equatable/equatable.dart';

import 'transaction_type.dart';

class CreateStockMovementRequestEntity extends Equatable {
  const CreateStockMovementRequestEntity({
    required this.transactionType,
    required this.quantity,
    this.note,
  });

  final TransactionType transactionType;
  final double quantity;
  final String? note;

  @override
  List<Object?> get props => [transactionType, quantity, note];
}
