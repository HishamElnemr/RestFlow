import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/customers/customers_cubit.dart';
import '../widgets/edit_customer_page_body.dart';

class EditCustomerPage extends StatelessWidget {
  const EditCustomerPage({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomersCubit>()..fetchCustomerById(customerId),
      child: Scaffold(
        body: SafeArea(
          child: EditCustomerPageBody(customerId: customerId),
        ),
      ),
    );
  }
}
