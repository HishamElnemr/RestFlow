import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_customers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_filter_button.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../core/widgets/filter_tabs_bar.dart';
import '../../domain/entities/customer_status.dart';
import '../cubit/customers/customers_cubit.dart';
import '../cubit/customers/customers_state.dart';
import 'customer_item_card.dart';
import 'customers_filter_bottom_sheet.dart';

class CustomersPageBody extends StatefulWidget {
  const CustomersPageBody({super.key});

  @override
  State<CustomersPageBody> createState() => _CustomersPageBodyState();
}

class _CustomersPageBodyState extends State<CustomersPageBody> {
  CustomerStatus? _selectedStatus;
  String? _searchQuery;
  Timer? _debounce;

  DateTime? _filterFromDate;
  DateTime? _filterToDate;

  bool get _hasActiveFilters =>
      _filterFromDate != null || _filterToDate != null;

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
          showBackButton: true,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _CustomersStickyHeaderDelegate(
            height: 148.0,
            child: Container(
              color: AppColors.backgroundLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          hintText: 'Search customers...',
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomFilterButton(
                        hasActiveFilters: _hasActiveFilters,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => CustomersFilterBottomSheet(
                              fromDate: _filterFromDate,
                              toDate: _filterToDate,
                              onApply: (fromDate, toDate) {
                                setState(() {
                                  _filterFromDate = fromDate;
                                  _filterToDate = toDate;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilterTabsBar<CustomerStatus?>(
                    items: const [
                      FilterTabItem(label: 'Active', value: CustomerStatus.active),
                      FilterTabItem(label: 'Inactive', value: CustomerStatus.inactive),
                    ],
                    selectedValue: _selectedStatus,
                    onChanged: (status) {
                      setState(() {
                        _selectedStatus = status;
                      });
                      _applyFilters();
                    },
                    allLabel: 'All',
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
            }

            if (state is CustomersListSuccess) {
              displayCustomers = state.customers;
            }

            // Apply local date filtering
            if (!isLoading) {
              displayCustomers = displayCustomers.where((c) {
                if (_filterFromDate != null) {
                  final from = DateTime(
                    _filterFromDate!.year,
                    _filterFromDate!.month,
                    _filterFromDate!.day,
                  );
                  final created = DateTime(
                    c.createdAt.year,
                    c.createdAt.month,
                    c.createdAt.day,
                  );
                  if (created.isBefore(from)) return false;
                }
                if (_filterToDate != null) {
                  final to = DateTime(
                    _filterToDate!.year,
                    _filterToDate!.month,
                    _filterToDate!.day,
                  );
                  final created = DateTime(
                    c.createdAt.year,
                    c.createdAt.month,
                    c.createdAt.day,
                  );
                  if (created.isAfter(to)) return false;
                }
                return true;
              }).toList();
            }

            if (!isLoading && displayCustomers.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text('No customers found.'),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: Skeletonizer.sliver(
                enabled: isLoading,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
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
  _CustomersStickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
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
