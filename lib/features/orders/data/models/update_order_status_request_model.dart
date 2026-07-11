import 'package:rest_flow/features/orders/domain/enums/order_status.dart';

import '../../domain/entities/update_order_status_request_entity.dart';

class UpdateOrderStatusRequestModel extends UpdateOrderStatusRequestEntity {
  const UpdateOrderStatusRequestModel({
    super.status,
  });

  factory UpdateOrderStatusRequestModel.fromEntity(
      UpdateOrderStatusRequestEntity entity) {
    return UpdateOrderStatusRequestModel(
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() {
    String? statusStr;
    if (status != null) {
      switch (status!) {
        case OrderStatus.pending: statusStr = 'Pending'; break;
        case OrderStatus.completed: statusStr = 'Completed'; break;
        case OrderStatus.cancelled: statusStr = 'Cancelled'; break;
      }
    }
    return {
      if (statusStr != null) 'status': statusStr,
    };
  }
}
