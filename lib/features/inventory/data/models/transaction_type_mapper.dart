import '../../domain/entities/transaction_type.dart';

TransactionType parseTransactionType(dynamic value) {
  final text = value?.toString() ?? '';
  switch (text) {
    case 'StockIn':
      return TransactionType.stockIn;
    case 'StockOut':
      return TransactionType.stockOut;
    case 'Adjustment':
      return TransactionType.adjustment;
    default:
      return TransactionType.stockIn;
  }
}

String transactionTypeToJson(TransactionType value) {
  switch (value) {
    case TransactionType.stockIn:
      return 'StockIn';
    case TransactionType.stockOut:
      return 'StockOut';
    case TransactionType.adjustment:
      return 'Adjustment';
  }
}
