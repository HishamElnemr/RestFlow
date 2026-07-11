import 'package:equatable/equatable.dart';

import '../enums/order_status.dart';

class UpdateOrderStatusRequestEntity extends Equatable {
  const UpdateOrderStatusRequestEntity({
    this.status,
  });

  final OrderStatus? status;

  @override
  List<Object?> get props => [
        status,
      ];
}
