import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/inventory/presentation/cubit/low_stock_count/low_stock_count_cubit.dart';
import 'package:rest_flow/features/inventory/presentation/cubit/low_stock_count/low_stock_count_state.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_cubit.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_state.dart';
import 'package:rest_flow/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:rest_flow/features/orders/presentation/cubit/orders_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import 'stat_card.dart';

class DashboardStatCardsRow extends StatelessWidget {
  const DashboardStatCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              final isLoading = state is OrdersLoading;
              final value = state is OrdersListSuccess
                  ? state.orders.length.toString()
                  : '100';

              return Skeletonizer(
                enabled: isLoading,
                child: StatCard(
                  svgAsset: 'assets/images/onboarding2.svg',
                  title: 'Total Orders',
                  value: value,
                  iconColor: AppColors.primary,
                  iconBgColor: AppColors.primary.withOpacity(0.08),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BlocBuilder<MenuProductsCubit, MenuProductsState>(
            builder: (context, state) {
              final isLoading = state is MenuProductsLoading;
              final value = state is MenuProductsListSuccess
                  ? state.products
                      .where((product) => product.isAvailable)
                      .length
                      .toString()
                  : '50';

              return Skeletonizer(
                enabled: isLoading,
                child: StatCard(
                  svgAsset: 'assets/images/onboarding3.svg',
                  title: 'Active Products',
                  value: value,
                  iconColor: AppColors.oliveGreen,
                  iconBgColor: AppColors.oliveGreenLight,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BlocBuilder<LowStockCountCubit, LowStockCountState>(
            builder: (context, state) {
              final isLoading = state is LowStockCountLoading;
              final value =
                  state is LowStockCountSuccess ? state.count.toString() : '5';

              return Skeletonizer(
                enabled: isLoading,
                child: StatCard(
                  icon: Icons.warning_amber_rounded,
                  title: 'Low Stock',
                  value: value,
                  iconColor: AppColors.orange,
                  iconBgColor: AppColors.warningBg,
                  borderColor: AppColors.orange.withOpacity(0.6),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
