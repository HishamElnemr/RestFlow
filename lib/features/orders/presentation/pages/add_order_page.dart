import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_cubit.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/add_order_page_body.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<OrdersCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CustomersCubit>()..fetchCustomers(),
        ),
        BlocProvider(
          create: (context) => getIt<MenuProductsCubit>()..fetchProducts(),
        ),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: AddOrderPageBody(),
        ),
      ),
    );
  }
}
