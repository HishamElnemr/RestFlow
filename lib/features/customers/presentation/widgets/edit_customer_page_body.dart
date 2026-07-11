import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/customer_status.dart';
import '../../domain/entities/update_customer_request_entity.dart';
import '../../domain/entities/update_customer_status_request_entity.dart';
import '../cubit/customers/customers_cubit.dart';
import '../cubit/customers/customers_state.dart';
import 'customer_form_fields.dart';
import 'customer_save_button.dart';

class EditCustomerPageBody extends StatefulWidget {
  const EditCustomerPageBody({super.key, required this.customerId});

  final String customerId;

  @override
  State<EditCustomerPageBody> createState() => _EditCustomerPageBodyState();
}

class _EditCustomerPageBodyState extends State<EditCustomerPageBody> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _phoneNumber = '';
  bool _isActive = true;
  bool _initialIsActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomersCubit, CustomersState>(
      listener: (context, state) {
        if (state is CustomerDetailsSuccess) {
          setState(() {
            _fullName = state.customer.fullName;
            _phoneNumber = state.customer.phoneNumber;
            _initialIsActive = state.customer.status == CustomerStatus.active;
            _isActive = _initialIsActive;
          });
        } else if (state is CustomerActionSuccess) {
          if (state.action == CustomersAction.update) {
            if (_isActive != _initialIsActive) {
              final status = _isActive ? CustomerStatus.active : CustomerStatus.inactive;
              context.read<CustomersCubit>().updateCustomerStatus(
                    widget.customerId,
                    UpdateCustomerStatusRequestEntity(status: status),
                  );
            } else {
              log('[EditCustomerPageBody] update SUCCESS -> popping with true');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Customer updated successfully'),
                  backgroundColor: AppColors.successBright,
                ),
              );
              Navigator.of(context).pop(true);
            }
          } else if (state.action == CustomersAction.updateStatus) {
            log('[EditCustomerPageBody] updateStatus SUCCESS -> popping with true');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer updated successfully'),
                backgroundColor: AppColors.successBright,
              ),
            );
            Navigator.of(context).pop(true);
          }
        } else if (state is CustomersFailure) {
          if (state.action == CustomersAction.update ||
              state.action == CustomersAction.updateStatus) {
            log('[EditCustomerPageBody] ${state.action} FAILED: ${state.failure.message}');
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
        final isFetching = state is CustomersLoading &&
            state.action == CustomersAction.fetchById;
        final isUpdating = state is CustomersLoading &&
            (state.action == CustomersAction.update ||
             state.action == CustomersAction.updateStatus);

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Edit Customer',
                    showBackButton: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Skeletonizer(
                        enabled: isFetching,
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
                label: 'Save Changes',
                isLoading: isUpdating,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final request = UpdateCustomerRequestEntity(
                      fullName: _fullName,
                      phoneNumber: _phoneNumber,
                    );
                    context
                        .read<CustomersCubit>()
                        .updateCustomer(widget.customerId, request);
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
