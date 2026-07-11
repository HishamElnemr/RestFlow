import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/employees_cubit.dart';
import '../widgets/employees_page_body.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmployeesCubit>()..fetchEmployees(),
      child: const Scaffold(
        body: SafeArea(
          child: EmployeesPageBody(),
        ),
      ),
    );
  }
}
