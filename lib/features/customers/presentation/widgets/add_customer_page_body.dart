import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/create_customer_request_entity.dart';
import '../../domain/entities/customer_status.dart';
import '../../domain/entities/update_customer_status_request_entity.dart';
import '../cubit/customers/customers_cubit.dart';
import '../cubit/customers/customers_state.dart';
import 'customer_form_fields.dart';
import 'customer_save_button.dart';

class AddCustomerPageBody extends StatefulWidget {
  const AddCustomerPageBody({super.key});

  @override
  State<AddCustomerPageBody> createState() => _AddCustomerPageBodyState();
}

class _AddCustomerPageBodyState extends State<AddCustomerPageBody> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _phoneNumber = '';
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomersCubit, CustomersState>(
      listener: (context, state) {
        if (state is CustomerActionSuccess) {
          if (state.action == CustomersAction.create) {
            if (!_isActive && state.response.data != null) {
              context.read<CustomersCubit>().updateCustomerStatus(
                    state.response.data!.id,
                    const UpdateCustomerStatusRequestEntity(
                        status: CustomerStatus.inactive),
                  );
            } else {
              log('[AddCustomerPageBody] create SUCCESS -> popping with true');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Customer added successfully'),
                  backgroundColor: AppColors.successBright,
                ),
              );
              Navigator.of(context).pop(true);
            }
          } else if (state.action == CustomersAction.updateStatus) {
            log('[AddCustomerPageBody] updateStatus SUCCESS -> popping with true');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer added successfully'),
                backgroundColor: AppColors.successBright,
              ),
            );
            Navigator.of(context).pop(true);
          }
        } else if (state is CustomersFailure) {
          if (state.action == CustomersAction.create ||
              state.action == CustomersAction.updateStatus) {
            log('[AddCustomerPageBody] ${state.action} FAILED: ${state.failure.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        final isCreating = state is CustomersLoading &&
            (state.action == CustomersAction.create ||
                state.action == CustomersAction.updateStatus);

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Add Customer',
                    showBackButton: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Form(
                        key: _formKey,
                        child: CustomerFormFields(
                          initialFullName: _fullName,
                          initialPhoneNumber: _phoneNumber,
                          initialIsActive: _isActive,
                          onFullNameChanged: (val) => _fullName = val,
                          onPhoneNumberChanged: (val) => _phoneNumber = val,
                          onIsActiveChanged: (val) => _isActive = val,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 32.0,
              ),
              child: CustomerSaveButton(
                label: 'Add Customer',
                isLoading: isCreating,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final request = CreateCustomerRequestEntity(
                      fullName: _fullName,
                      phoneNumber: _phoneNumber,
                    );
                    context.read<CustomersCubit>().createCustomer(request);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
