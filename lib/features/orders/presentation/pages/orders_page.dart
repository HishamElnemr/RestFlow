import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/orders_page_body.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: const SafeArea(
        child: OrdersPageBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.white,
          size: 28,
        ),
      ),
    );
  }
}
