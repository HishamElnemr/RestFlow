import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue('Pending')
  pending(1),
  @JsonValue('Completed')
  completed(2),
  @JsonValue('Cancelled')
  cancelled(3);

  final int value;
  const OrderStatus(this.value);

  factory OrderStatus.fromValue(int value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
