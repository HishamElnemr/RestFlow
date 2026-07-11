import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/create_employee_request_entity.dart';
import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_status_request_entity.dart';
import '../cubit/employees_cubit.dart';
import '../cubit/employees_state.dart';
import 'employee_form_fields.dart';
import 'employee_save_button.dart';

class AddEmployeePageBody extends StatefulWidget {
  const AddEmployeePageBody({super.key});

  @override
  State<AddEmployeePageBody> createState() => _AddEmployeePageBodyState();
}

class _AddEmployeePageBodyState extends State<AddEmployeePageBody> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _role = 'Cashier';
  String _password = '';
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeeActionSuccess) {
          if (state.action == EmployeesAction.create) {
            if (!_isActive && state.response.data != null) {
              context.read<EmployeesCubit>().updateEmployeeStatus(
                    state.response.data!.id,
                    const UpdateEmployeeStatusRequestEntity(
                        status: EmployeeStatus.inactive),
                  );
            } else {
              log('[AddEmployeePageBody] create SUCCESS -> popping with true');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Employee added successfully'),
                  backgroundColor: AppColors.successBright,
                ),
              );
              Navigator.of(context).pop(true);
            }
          } else if (state.action == EmployeesAction.updateStatus) {
            log('[AddEmployeePageBody] updateStatus SUCCESS -> popping with true');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Employee added successfully'),
                backgroundColor: AppColors.successBright,
              ),
            );
            Navigator.of(context).pop(true);
          }
        } else if (state is EmployeesFailure) {
          if (state.action == EmployeesAction.create ||
              state.action == EmployeesAction.updateStatus) {
            log('[AddEmployeePageBody] ${state.action} FAILED: ${state.failure.message}');
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
        final isCreating = state is EmployeesLoading &&
            (state.action == EmployeesAction.create ||
                state.action == EmployeesAction.updateStatus);

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Add Employee',
                    showBackButton: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Form(
                        key: _formKey,
                        child: EmployeeFormFields(
                          initialFullName: _fullName,
                          initialEmail: _email,
                          initialPhoneNumber: _phoneNumber,
                          initialRole: _role,
                          initialIsActive: _isActive,
                          initialPassword: _password,
                          onFullNameChanged: (val) => _fullName = val,
                          onEmailChanged: (val) => _email = val,
                          onPhoneNumberChanged: (val) => _phoneNumber = val,
                          onRoleChanged: (val) => _role = val,
                          onIsActiveChanged: (val) => _isActive = val,
                          onPasswordChanged: (val) => _password = val,
                          isEditing: false,
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
              child: EmployeeSaveButton(
                label: 'Add Employee',
                isLoading: isCreating,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final request = CreateEmployeeRequestEntity(
                      fullName: _fullName,
                      email: _email,
                      phoneNumber: _phoneNumber,
                      role: _role,
                      password: _password,
                    );
                    context.read<EmployeesCubit>().createEmployee(request);
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
