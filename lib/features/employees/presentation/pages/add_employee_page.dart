import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/employees_cubit.dart';
import '../widgets/add_employee_page_body.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmployeesCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: AddEmployeePageBody(),
        ),
      ),
    );
  }
}
