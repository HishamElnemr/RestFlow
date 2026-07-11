import 'package:equatable/equatable.dart';

import '../enums/payment_status.dart';

class UpdatePaymentStatusRequestEntity extends Equatable {
  const UpdatePaymentStatusRequestEntity({
    this.status,
  });

  final PaymentStatus? status;

  @override
  List<Object?> get props => [
        status,
      ];
}
