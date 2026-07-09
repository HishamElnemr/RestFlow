import 'package:json_annotation/json_annotation.dart';

enum OrderType {
  @JsonValue('DineIn')
  dineIn(1),
  @JsonValue('Takeaway')
  takeaway(2),
  @JsonValue('Delivery')
  delivery(3);

  final int value;
  const OrderType(this.value);

  factory OrderType.fromValue(int value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => OrderType.dineIn,
    );
  }
}
