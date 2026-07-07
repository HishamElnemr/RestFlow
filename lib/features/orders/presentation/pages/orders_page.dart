import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/orders_page_body.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrdersCubit>()..fetchOrders(),
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: OrdersPageBody(),
        ),
      ),
    );
  }
}
