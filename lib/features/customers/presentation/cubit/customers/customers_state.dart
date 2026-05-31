import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/customer_response_entity.dart';

enum CustomersAction { fetchList, fetchById, create, update, updateStatus }

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object?> get props => [];
}

class CustomersInitial extends CustomersState {
  const CustomersInitial();
}

class CustomersLoading extends CustomersState {
  const CustomersLoading(this.action);

  final CustomersAction action;

  @override
  List<Object?> get props => [action];
}

class CustomersListSuccess extends CustomersState {
  const CustomersListSuccess(this.customers);

  final List<CustomerEntity> customers;

  @override
  List<Object?> get props => [customers];
}

class CustomerDetailsSuccess extends CustomersState {
  const CustomerDetailsSuccess(this.customer);

  final CustomerEntity customer;

  @override
  List<Object?> get props => [customer];
}

class CustomerActionSuccess extends CustomersState {
  const CustomerActionSuccess(this.response, this.action);

  final CustomerResponseEntity response;
  final CustomersAction action;

  @override
  List<Object?> get props => [response, action];
}

class CustomersFailure extends CustomersState {
  const CustomersFailure(this.failure, this.action);

  final AppFailure failure;
  final CustomersAction action;

  @override
  List<Object?> get props => [failure, action];
}
