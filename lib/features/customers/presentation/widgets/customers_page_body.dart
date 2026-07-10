import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_customers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/customer_status.dart';
import '../cubit/customers/customers_cubit.dart';
import '../cubit/customers/customers_state.dart';
import 'customer_item_card.dart';
import 'customers_filter_tabs.dart';
import 'customers_search_bar.dart';

class CustomersPageBody extends StatefulWidget {
  const CustomersPageBody({super.key});

  @override
  State<CustomersPageBody> createState() => _CustomersPageBodyState();
}

class _CustomersPageBodyState extends State<CustomersPageBody> {
  CustomerStatus? _selectedStatus;
  String? _searchQuery;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _applyFilters() {
    context.read<CustomersCubit>().fetchCustomers(
          search: _searchQuery,
          status: _selectedStatus,
        );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchQuery = query.isEmpty ? null : query;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Customers',
          showBackButton: false,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _CustomersStickyHeaderDelegate(
            height: 140.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  CustomersSearchBar(
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: 16),
                  CustomersFilterTabs(
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
        BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            final isLoading = state is CustomersLoading || state is CustomersInitial;
            var displayCustomers = dummyCustomers;

            if (state is CustomersFailure) {
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
            } else if (state is CustomersListSuccess) {
              displayCustomers = state.customers;
            }

            if (!isLoading && displayCustomers.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No customers found.',
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
                        child: CustomerItemCard(customer: displayCustomers[index]),
                      );
                    },
                    childCount: displayCustomers.length,
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

class _CustomersStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _CustomersStickyHeaderDelegate({required this.child, required this.height});

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
  bool shouldRebuild(covariant _CustomersStickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
