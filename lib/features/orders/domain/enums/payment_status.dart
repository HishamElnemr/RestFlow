import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue(1)
  unpaid(1),
  @JsonValue(2)
  paid(2);

  final int value;
  const PaymentStatus(this.value);

  factory PaymentStatus.fromValue(int value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => PaymentStatus.unpaid,
    );
  }
}
