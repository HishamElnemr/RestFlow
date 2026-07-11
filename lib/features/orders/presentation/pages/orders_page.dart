import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/orders_page_body.dart';
import 'add_order_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrdersCubit>()..fetchOrders(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddOrderPage()),
              ).then((value) {
                if (value == true) {
                  context.read<OrdersCubit>().fetchOrders();
                }
              });
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: const SafeArea(
          child: OrdersPageBody(),
        ),
      ),
    );
  }
}
