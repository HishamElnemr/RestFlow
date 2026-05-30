import 'package:equatable/equatable.dart';

import 'customer_status.dart';

class CustomerEntity extends Equatable {
  const CustomerEntity({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final CustomerStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    fullName,
    phoneNumber,
    status,
    createdAt,
    updatedAt,
  ];
}
