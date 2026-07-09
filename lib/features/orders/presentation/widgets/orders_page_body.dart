import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_orders.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import 'order_item_card.dart';
import 'orders_filter_bottom_sheet.dart';
import 'orders_filter_button.dart';
import 'orders_filter_tabs.dart';
import 'orders_search_bar.dart';

class OrdersPageBody extends StatefulWidget {
  const OrdersPageBody({super.key});

  @override
  State<OrdersPageBody> createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  OrderStatus? _selectedStatus;
  PaymentStatus? _selectedPaymentStatus;
  OrderType? _selectedOrderType;
  String? _fromDate;
  String? _toDate;

  bool get _hasActiveExtraFilters =>
      _selectedPaymentStatus != null ||
      _selectedOrderType != null ||
      _fromDate != null ||
      _toDate != null;

  void _applyFilters() {
    context.read<OrdersCubit>().fetchOrders(
          status: _selectedStatus,
          paymentStatus: _selectedPaymentStatus,
          orderType: _selectedOrderType,
          fromDate: _fromDate,
          toDate: _toDate,
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Orders',
            style: AppStyles.heading3SemiBold18(context).copyWith(
              color: AppColors.darkNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          floating: true,
          iconTheme: const IconThemeData(color: AppColors.darkNavy),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _OrdersStickyHeaderDelegate(
            height: 156.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OrdersSearchBar(
                          onChanged: (query) {
                            context.read<OrdersCubit>().fetchOrders(
                                  search: query,
                                  status: _selectedStatus,
                                  paymentStatus: _selectedPaymentStatus,
                                  orderType: _selectedOrderType,
                                  fromDate: _fromDate,
                                  toDate: _toDate,
                                );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      OrdersFilterButton(
                        hasActiveFilters: _hasActiveExtraFilters,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (_) => OrdersFilterBottomSheet(
                              selectedPaymentStatus: _selectedPaymentStatus,
                              selectedOrderType: _selectedOrderType,
                              fromDate: _fromDate,
                              toDate: _toDate,
                              onApply: (paymentStatus, orderType, from, to) {
                                setState(() {
                                  _selectedPaymentStatus = paymentStatus;
                                  _selectedOrderType = orderType;
                                  _fromDate = from;
                                  _toDate = to;
                                });
                                _applyFilters();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OrdersFilterTabs(
                    selectedStatus: _selectedStatus,
                    onStatusChanged: (status) {
                      setState(() {
                        _selectedStatus = status;
                      });
                      _applyFilters();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            final isLoading = state is OrdersLoading || state is OrdersInitial;
            var displayOrders = dummyOrders;

            if (state is OrdersError) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.failure.message,
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              );
            } else if (state is OrdersLoaded) {
              displayOrders = state.orders;
            }

            if (!isLoading && displayOrders.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No orders found.',
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.mutedGray,
                    ),
                  ),
                ),
              );
            }

            return Skeletonizer.sliver(
              enabled: isLoading,
              containersColor: Colors.grey.shade100,
              ignoreContainers: false,
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade50,
              ),
              child: SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    .copyWith(bottom: 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OrderItemCard(order: displayOrders[index]),
                      );
                    },
                    childCount: displayOrders.length,
                  ),
                ),
              ),
            );
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
