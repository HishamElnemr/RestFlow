import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/customers/customers_cubit.dart';
import '../widgets/customers_page_body.dart';
import 'add_customer_page.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomersCubit>()..fetchCustomers(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => const AddCustomerPage(),
                  ),
                )
                    .then((result) {
                  if (result == true && context.mounted) {
                    context.read<CustomersCubit>().fetchCustomers();
                  }
                });
              },
              backgroundColor: AppColors.electricBlue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            );
          }
        ),
        body: const SafeArea(
          child: CustomersPageBody(),
        ),
      ),
    );
  }
}
