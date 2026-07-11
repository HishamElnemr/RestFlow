import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_request_entity.dart';
import '../../domain/entities/update_employee_status_request_entity.dart';
import '../cubit/employees_cubit.dart';
import '../cubit/employees_state.dart';
import 'employee_form_fields.dart';
import 'employee_save_button.dart';

class EditEmployeePageBody extends StatefulWidget {
  const EditEmployeePageBody({super.key, required this.employeeId});

  final String employeeId;

  @override
  State<EditEmployeePageBody> createState() => _EditEmployeePageBodyState();
}

class _EditEmployeePageBodyState extends State<EditEmployeePageBody> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _role = '';
  bool _isActive = true;
  bool _initialIsActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeeDetailsSuccess) {
          setState(() {
            _fullName = state.employee.fullName;
            _email = state.employee.email;
            _phoneNumber = state.employee.phoneNumber;
            _role = state.employee.role;
            _initialIsActive = state.employee.status == EmployeeStatus.active;
            _isActive = _initialIsActive;
          });
        } else if (state is EmployeeActionSuccess) {
          if (state.action == EmployeesAction.update) {
            if (_isActive != _initialIsActive) {
              final status =
                  _isActive ? EmployeeStatus.active : EmployeeStatus.inactive;
              context.read<EmployeesCubit>().updateEmployeeStatus(
                    widget.employeeId,
                    UpdateEmployeeStatusRequestEntity(status: status),
                  );
            } else {
              log('[EditEmployeePageBody] update SUCCESS -> popping with true');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Employee updated successfully'),
                  backgroundColor: AppColors.successBright,
                ),
              );
              Navigator.of(context).pop(true);
            }
          } else if (state.action == EmployeesAction.updateStatus) {
            log('[EditEmployeePageBody] updateStatus SUCCESS -> popping with true');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Employee updated successfully'),
                backgroundColor: AppColors.successBright,
              ),
            );
            Navigator.of(context).pop(true);
          }
        } else if (state is EmployeesFailure) {
          if (state.action == EmployeesAction.update ||
              state.action == EmployeesAction.updateStatus) {
            log('[EditEmployeePageBody] ${state.action} FAILED: ${state.failure.message}');
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
        final isFetching = state is EmployeesLoading &&
            state.action == EmployeesAction.fetchById;
        final isUpdating = state is EmployeesLoading &&
            (state.action == EmployeesAction.update ||
                state.action == EmployeesAction.updateStatus);

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Edit Employee',
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
                          child: EmployeeFormFields(
                            initialFullName: _fullName,
                            initialEmail: _email,
                            initialPhoneNumber: _phoneNumber,
                            initialRole: _role,
                            initialIsActive: _isActive,
                            onFullNameChanged: (val) => _fullName = val,
                            onEmailChanged: (val) => _email = val,
                            onPhoneNumberChanged: (val) => _phoneNumber = val,
                            onRoleChanged: (val) => _role = val,
                            onIsActiveChanged: (val) => _isActive = val,
                            isEditing: true,
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
              child: EmployeeSaveButton(
                label: 'Save Changes',
                isLoading: isUpdating,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final request = UpdateEmployeeRequestEntity(
                      fullName: _fullName,
                      email: _email,
                      phoneNumber: _phoneNumber,
                      role: _role,
                      // Note: We update status via separate endpoint to match customer flow
                    );
                    context
                        .read<EmployeesCubit>()
                        .updateEmployee(widget.employeeId, request);
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
