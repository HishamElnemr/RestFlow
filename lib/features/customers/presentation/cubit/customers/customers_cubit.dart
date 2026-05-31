import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_customer_request_entity.dart';
import '../../../domain/entities/customer_status.dart';
import '../../../domain/entities/update_customer_request_entity.dart';
import '../../../domain/entities/update_customer_status_request_entity.dart';
import '../../../domain/repositories/customers_repository.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._repository) : super(const CustomersInitial());

  final CustomersRepository _repository;

  Future<void> fetchCustomers({String? search, CustomerStatus? status}) async {
    emit(const CustomersLoading(CustomersAction.fetchList));
    final result = await _repository.fetchCustomers(
      search: search,
      status: status,
    );
    result.fold(
      (failure) => emit(CustomersFailure(failure, CustomersAction.fetchList)),
      (customers) => emit(CustomersListSuccess(customers)),
    );
  }

  Future<void> fetchCustomerById(String id) async {
    emit(const CustomersLoading(CustomersAction.fetchById));
    final result = await _repository.fetchCustomerById(id);
    result.fold(
      (failure) => emit(CustomersFailure(failure, CustomersAction.fetchById)),
      (customer) => emit(CustomerDetailsSuccess(customer)),
    );
  }

  Future<void> createCustomer(CreateCustomerRequestEntity request) async {
    emit(const CustomersLoading(CustomersAction.create));
    final result = await _repository.createCustomer(request);
    result.fold(
      (failure) => emit(CustomersFailure(failure, CustomersAction.create)),
      (response) =>
          emit(CustomerActionSuccess(response, CustomersAction.create)),
    );
  }

  Future<void> updateCustomer(
    String id,
    UpdateCustomerRequestEntity request,
  ) async {
    emit(const CustomersLoading(CustomersAction.update));
    final result = await _repository.updateCustomer(id, request);
    result.fold(
      (failure) => emit(CustomersFailure(failure, CustomersAction.update)),
      (response) =>
          emit(CustomerActionSuccess(response, CustomersAction.update)),
    );
  }

  Future<void> updateCustomerStatus(
    String id,
    UpdateCustomerStatusRequestEntity request,
  ) async {
    emit(const CustomersLoading(CustomersAction.updateStatus));
    final result = await _repository.updateCustomerStatus(id, request);
    result.fold(
      (failure) =>
          emit(CustomersFailure(failure, CustomersAction.updateStatus)),
      (response) =>
          emit(CustomerActionSuccess(response, CustomersAction.updateStatus)),
    );
  }

  void reset() {
    emit(const CustomersInitial());
  }
}
