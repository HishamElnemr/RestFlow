import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/presentation/pages/menu_page.dart';
import 'package:rest_flow/features/owner_dashboard/presentation/pages/owner_dashboard_page.dart';
import 'package:rest_flow/features/orders/presentation/pages/orders_page.dart';
import 'package:rest_flow/features/ai/presentation/pages/ai_dashboard_page.dart';
import '../cubit/layout_cubit.dart';

class LayoutPageBody extends StatelessWidget {
  const LayoutPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, int>(
      builder: (context, currentIndex) {
        return IndexedStack(
          index: currentIndex,
          children: const [
            OwnerDashboardPage(),
            OrdersPage(),
            MenuPage(),
            AiDashboardPage(),
            Center(child: Text('More Settings (Coming Soon)')),
          ],
        );
      },
    );
  }
}
