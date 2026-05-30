import 'package:equatable/equatable.dart';

import 'customer_entity.dart';

class CustomerResponseEntity extends Equatable {
  const CustomerResponseEntity({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  final bool isSuccess;
  final String message;
  final CustomerEntity? data;

  @override
  List<Object?> get props => [isSuccess, message, data];
}
