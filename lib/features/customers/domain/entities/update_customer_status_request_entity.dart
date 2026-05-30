import 'package:equatable/equatable.dart';

import 'customer_status.dart';

class UpdateCustomerStatusRequestEntity extends Equatable {
  const UpdateCustomerStatusRequestEntity({required this.status});

  final CustomerStatus status;

  @override
  List<Object?> get props => [status];
}
