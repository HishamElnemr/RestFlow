import 'package:rest_flow/features/orders/domain/enums/payment_status.dart';

import '../../domain/entities/update_payment_status_request_entity.dart';

class UpdatePaymentStatusRequestModel extends UpdatePaymentStatusRequestEntity {
  const UpdatePaymentStatusRequestModel({
    super.status,
  });

  factory UpdatePaymentStatusRequestModel.fromEntity(
      UpdatePaymentStatusRequestEntity entity) {
    return UpdatePaymentStatusRequestModel(
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() {
    String? statusStr;
    if (status != null) {
      switch (status!) {
        case PaymentStatus.unpaid: statusStr = 'Unpaid'; break;
        case PaymentStatus.paid: statusStr = 'Paid'; break;
      }
    }
    return {
      if (statusStr != null) 'status': statusStr,
    };
  }
}
