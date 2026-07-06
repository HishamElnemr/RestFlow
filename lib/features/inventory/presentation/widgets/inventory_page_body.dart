import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/inventory/domain/entities/inventory_item_list_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../cubit/inventory_items/inventory_items_state.dart';
import 'inventory_filter_chips.dart';
import 'inventory_item_card.dart';
import 'inventory_search_bar.dart';

class InventoryPageBody extends StatefulWidget {
  const InventoryPageBody({super.key});

  @override
  State<InventoryPageBody> createState() => _InventoryPageBodyState();
}

class _InventoryPageBodyState extends State<InventoryPageBody> {
  InventoryFilter _selectedFilter = InventoryFilter.all;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text(
            'Inventory',
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
          delegate: _StickyHeaderDelegate(
            height: 152.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  InventorySearchBar(
                    onChanged: (query) {
                      context
                          .read<InventoryItemsCubit>()
                          .fetchInventoryItems(search: query);
                    },
                  ),
                  const SizedBox(height: 16),
                  InventoryFilterChips(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            if (state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.fetchList) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is InventoryItemsFailure &&
                state.action == InventoryItemsAction.fetchList) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              );
            } else if (state is InventoryItemsListSuccess) {
              final filteredItems = _applyClientFilter(state.items);

              if (filteredItems.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No inventory items found.',
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
                        child: InventoryItemCard(item: filteredItems[index]),
                      );
                    },
                    childCount: filteredItems.length,
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

  List<InventoryItemListEntity> _applyClientFilter(
      List<InventoryItemListEntity> items) {
    if (_selectedFilter == InventoryFilter.lowStock) {
      return items
          .where((item) =>
              item.currentQuantity <= item.minimumQuantity &&
              item.currentQuantity > 0)
          .toList();
    } else if (_selectedFilter == InventoryFilter.outOfStock) {
      return items.where((item) => item.currentQuantity == 0).toList();
    }
    return items;
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({required this.child, required this.height});

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
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
