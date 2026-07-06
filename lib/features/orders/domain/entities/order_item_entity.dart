class OrderItemEntity {
  final String id;
  final String orderId;
  final String productId;
  final String? productName;
  final String? productNameSnapshot;
  final double? unitPrice;
  final double? quantity;
  final double? lineTotal;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    this.productName,
    this.productNameSnapshot,
    this.unitPrice,
    this.quantity,
    this.lineTotal,
  });
}
