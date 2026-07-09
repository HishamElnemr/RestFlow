import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/inventory/presentation/cubit/low_stock_count/low_stock_count_cubit.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_cubit.dart';
import 'package:rest_flow/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_cubit.dart';
import 'package:rest_flow/features/ai/presentation/cubit/ai_dashboard/ai_dashboard_cubit.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';

import '../widgets/owner_dashboard_page_body.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ReportsCubit>()),
        BlocProvider(create: (context) => getIt<OrdersCubit>()..fetchOrders()),
        BlocProvider(create: (context) => getIt<MenuProductsCubit>()..fetchProducts()),
        BlocProvider(create: (context) => getIt<LowStockCountCubit>()..fetchLowStockCount()),
        BlocProvider(create: (context) => getIt<AiDashboardCubit>()..fetchInsights()),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: OwnerDashboardPageBody(),
        ),
      ),
    );
  }
}
