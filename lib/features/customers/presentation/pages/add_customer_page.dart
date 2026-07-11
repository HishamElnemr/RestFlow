import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/customers/customers_cubit.dart';
import '../widgets/add_customer_page_body.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomersCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: AddCustomerPageBody(),
        ),
      ),
    );
  }
}
