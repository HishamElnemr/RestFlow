import 'package:rest_flow/features/customers/domain/entities/customer_entity.dart';
import 'package:rest_flow/features/customers/domain/entities/customer_status.dart';

final List<CustomerEntity> dummyCustomers = [
  CustomerEntity(
    id: '1',
    fullName: 'John Doe',
    phoneNumber: '+1234567890',
    status: CustomerStatus.active,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  CustomerEntity(
    id: '2',
    fullName: 'Jane Smith',
    phoneNumber: '+1987654321',
    status: CustomerStatus.active,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  CustomerEntity(
    id: '3',
    fullName: 'Ahmed Ali',
    phoneNumber: '+1122334455',
    status: CustomerStatus.inactive,
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
  ),
  CustomerEntity(
    id: '4',
    fullName: 'Sara Ahmed',
    phoneNumber: '+1555666777',
    status: CustomerStatus.active,
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
  ),
];
