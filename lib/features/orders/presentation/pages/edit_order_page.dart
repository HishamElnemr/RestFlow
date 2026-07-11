import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/edit_order_page_body.dart';

class EditOrderPage extends StatelessWidget {
  const EditOrderPage({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..fetchOrderById(orderId),
      child: Scaffold(
        body: SafeArea(
          child: EditOrderPageBody(orderId: orderId),
        ),
      ),
    );
  }
}
