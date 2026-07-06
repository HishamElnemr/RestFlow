import 'package:json_annotation/json_annotation.dart';

enum OrderType {
  @JsonValue(1)
  dineIn(1),
  @JsonValue(2)
  takeaway(2),
  @JsonValue(3)
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
