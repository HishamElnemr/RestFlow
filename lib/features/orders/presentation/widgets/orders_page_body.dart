import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/enums/order_status.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import 'order_item_card.dart';
import 'orders_filter_tabs.dart';
import 'orders_search_bar.dart';

class OrdersPageBody extends StatefulWidget {
  const OrdersPageBody({super.key});

  @override
  State<OrdersPageBody> createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  OrderStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text(
            'Orders',
            style: TextStyle(
              color: AppColors.darkNavy,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          floating: true,
          iconTheme: IconThemeData(color: AppColors.darkNavy),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _OrdersStickyHeaderDelegate(
            height: 142.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  OrdersSearchBar(
                    onChanged: (query) {
                      context
                          .read<OrdersCubit>()
                          .fetchOrders(search: query, status: _selectedStatus);
                    },
                  ),
                  const SizedBox(height: 16),
                  OrdersFilterTabs(
                    selectedStatus: _selectedStatus,
                    onStatusChanged: (status) {
                      setState(() {
                        _selectedStatus = status;
                      });
                      context
                          .read<OrdersCubit>()
                          .fetchOrders(status: _selectedStatus);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is OrdersError) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              );
            } else if (state is OrdersLoaded) {
              final orders = state.orders;

              if (orders.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No orders found.',
                      style: TextStyle(color: AppColors.mutedGray),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    .copyWith(bottom: 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OrderItemCard(order: orders[index]),
                      );
                    },
                    childCount: orders.length,
                  ),
                ),
              );
            }

            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}

class _OrdersStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _OrdersStickyHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundLight,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _OrdersStickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
