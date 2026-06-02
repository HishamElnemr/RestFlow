import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/create_customer_request_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_status.dart';
import '../../domain/entities/update_customer_request_entity.dart';
import '../../domain/entities/update_customer_status_request_entity.dart';
import '../cubit/customers/customers_cubit.dart';
import '../cubit/customers/customers_state.dart';

class CustomersTestPage extends StatefulWidget {
  const CustomersTestPage({super.key});

  @override
  State<CustomersTestPage> createState() => _CustomersTestPageState();
}

class _CustomersTestPageState extends State<CustomersTestPage> {
  final _searchController = TextEditingController();
  final _fetchByIdController = TextEditingController();

  final _createNameController = TextEditingController();
  final _createPhoneController = TextEditingController();

  final _updateIdController = TextEditingController();
  final _updateNameController = TextEditingController();
  final _updatePhoneController = TextEditingController();

  final _statusIdController = TextEditingController();

  CustomerStatus? _filterStatus;
  CustomerStatus _updateStatus = CustomerStatus.active;

  @override
  void dispose() {
    _searchController.dispose();
    _fetchByIdController.dispose();
    _createNameController.dispose();
    _createPhoneController.dispose();
    _updateIdController.dispose();
    _updateNameController.dispose();
    _updatePhoneController.dispose();
    _statusIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers Sandbox'),
        backgroundColor: colorScheme.surface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Quick Customers Tests', style: AppStyles.title(context)),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Fetch Customers',
                child: _fetchSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Create Customer',
                child: _createSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Update Customer',
                child: _updateSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Update Status',
                child: _statusSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Fetch By Id',
                child: _fetchByIdSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Latest Result',
                child: _resultSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.section(context)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _fetchSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _searchController, label: 'Search'),
        const SizedBox(height: 12),
        _statusPicker(
          context,
          label: 'Status filter',
          value: _filterStatus,
          includeAll: true,
          onChanged: (value) => setState(() => _filterStatus = value),
        ),
        const SizedBox(height: 12),
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading =
                state is CustomersLoading &&
                state.action == CustomersAction.fetchList;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _onFetchPressed(context),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Fetch Customers'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _createSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _createNameController, label: 'Full name'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createPhoneController,
          label: 'Phone number',
        ),
        const SizedBox(height: 12),
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading =
                state is CustomersLoading &&
                state.action == CustomersAction.create;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _onCreatePressed(context),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _updateSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _updateIdController, label: 'Customer id'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateNameController,
          label: 'Full name (optional)',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updatePhoneController,
          label: 'Phone number (optional)',
        ),
        const SizedBox(height: 12),
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading =
                state is CustomersLoading &&
                state.action == CustomersAction.update;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _onUpdatePressed(context),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Update'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _statusSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _statusIdController, label: 'Customer id'),
        const SizedBox(height: 12),
        _statusPicker(
          context,
          label: 'Status',
          value: _updateStatus,
          includeAll: false,
          onChanged: (value) {
            if (value != null) {
              setState(() => _updateStatus = value);
            }
          },
        ),
        const SizedBox(height: 12),
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading =
                state is CustomersLoading &&
                state.action == CustomersAction.updateStatus;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _onStatusPressed(context),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Update Status'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _fetchByIdSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _fetchByIdController, label: 'Customer id'),
        const SizedBox(height: 12),
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading =
                state is CustomersLoading &&
                state.action == CustomersAction.fetchById;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () => _onFetchByIdPressed(context),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Fetch by id'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _resultSection(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        if (state is CustomersFailure) {
          return _stateMessage(context, state.failure.message);
        }
        if (state is CustomersListSuccess) {
          return _customersList(context, state.customers);
        }
        if (state is CustomerDetailsSuccess) {
          return _customerDetails(context, state.customer);
        }
        if (state is CustomerActionSuccess) {
          return _stateMessage(
            context,
            state.response.message.isNotEmpty
                ? state.response.message
                : 'Action completed.',
          );
        }
        if (state is CustomersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return _stateMessage(context, 'No results yet.');
      },
    );
  }

  Widget _customersList(BuildContext context, List<CustomerEntity> customers) {
    if (customers.isEmpty) {
      return _stateMessage(context, 'No customers found.');
    }
    return Column(
      children: customers
          .map(
            (customer) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(customer.fullName, style: AppStyles.body(context)),
                        const SizedBox(height: 4),
                        Text(
                          customer.phoneNumber,
                          style: AppStyles.label(context),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    customer.status.name.toUpperCase(),
                    style: AppStyles.label(context),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _customerDetails(BuildContext context, CustomerEntity customer) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.fullName, style: AppStyles.body(context)),
          const SizedBox(height: 6),
          Text(
            'Phone: ${customer.phoneNumber}',
            style: AppStyles.label(context),
          ),
          const SizedBox(height: 6),
          Text(
            'Status: ${customer.status.name}',
            style: AppStyles.label(context),
          ),
          const SizedBox(height: 6),
          Text('Id: ${customer.id}', style: AppStyles.label(context)),
        ],
      ),
    );
  }

  Widget _stateMessage(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message, style: AppStyles.body(context)),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label(context)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusPicker(
    BuildContext context, {
    required String label,
    required CustomerStatus? value,
    required bool includeAll,
    required ValueChanged<CustomerStatus?> onChanged,
  }) {
    final options = includeAll
        ? [null, ...CustomerStatus.values]
        : CustomerStatus.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label(context)),
        const SizedBox(height: 6),
        DropdownButtonFormField<CustomerStatus?>(
          initialValue: value,
          items: options
              .map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(
                    status == null ? 'All' : status.name.toUpperCase(),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  void _onFetchPressed(BuildContext context) {
    context.read<CustomersCubit>().fetchCustomers(
      search: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),
      status: _filterStatus,
    );
  }

  void _onFetchByIdPressed(BuildContext context) {
    final id = _fetchByIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<CustomersCubit>().fetchCustomerById(id);
  }

  void _onCreatePressed(BuildContext context) {
    context.read<CustomersCubit>().createCustomer(
      CreateCustomerRequestEntity(
        fullName: _createNameController.text.trim(),
        phoneNumber: _createPhoneController.text.trim(),
      ),
    );
  }

  void _onUpdatePressed(BuildContext context) {
    final id = _updateIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<CustomersCubit>().updateCustomer(
      id,
      UpdateCustomerRequestEntity(
        fullName: _updateNameController.text.trim().isEmpty
            ? null
            : _updateNameController.text.trim(),
        phoneNumber: _updatePhoneController.text.trim().isEmpty
            ? null
            : _updatePhoneController.text.trim(),
      ),
    );
  }

  void _onStatusPressed(BuildContext context) {
    final id = _statusIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<CustomersCubit>().updateCustomerStatus(
      id,
      UpdateCustomerStatusRequestEntity(status: _updateStatus),
    );
  }
}
