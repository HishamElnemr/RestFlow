import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(1)
  pending(1),
  @JsonValue(2)
  completed(2),
  @JsonValue(3)
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
