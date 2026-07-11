import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/dummy_data/dummy_orders.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../layout/presentation/cubit/layout_cubit.dart';
import '../../../orders/presentation/cubit/orders_cubit.dart';
import '../../../orders/presentation/cubit/orders_state.dart';
import 'recent_order_item_tile.dart';

class RecentOrdersList extends StatelessWidget {
  const RecentOrdersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: AppStyles.body1Medium16(context).copyWith(
                    color: AppColors.darkNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.read<LayoutCubit>().changeTab(1),
                  child: Text(
                    'View all',
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersError) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      state.failure.message,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (state is OrdersError) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      state.failure.message,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final isLoading =
                  state is OrdersLoading || state is OrdersInitial;

              var displayOrders = dummyOrders;

              if (state is OrdersListSuccess) {
                displayOrders = state.orders;
              }

              final ordersToShow = displayOrders.take(3).toList();

              if (!isLoading && ordersToShow.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text('No recent orders.'),
                  ),
                );
              }

              return Skeletonizer(
                enabled: isLoading,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ordersToShow.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: AppColors.borderLight,
                  ),
                  itemBuilder: (context, index) {
                    final order = ordersToShow[index];
                    return RecentOrderItemTile(order: order);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
