import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/employees_cubit.dart';
import '../widgets/edit_employee_page_body.dart';

class EditEmployeePage extends StatelessWidget {
  const EditEmployeePage({super.key, required this.employeeId});

  final String employeeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmployeesCubit>()..fetchEmployeeById(employeeId),
      child: Scaffold(
        body: SafeArea(
          child: EditEmployeePageBody(employeeId: employeeId),
        ),
      ),
    );
  }
}
