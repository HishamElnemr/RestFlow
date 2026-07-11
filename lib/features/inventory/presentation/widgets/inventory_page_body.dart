import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/inventory/domain/entities/inventory_item_list_entity.dart';
import 'package:rest_flow/features/inventory/presentation/widgets/inventory_filter_chips.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_inventory_items.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../cubit/inventory_items/inventory_items_state.dart';
import 'inventory_item_card.dart';
import 'inventory_sticky_header.dart';

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
        const CustomSliverAppBar(title: 'Inventory'),
        SliverPersistentHeader(
          pinned: true,
          delegate: InventoryStickyHeader(
            height: 152.0,
            selectedFilter: _selectedFilter,
            onSearchChanged: (query) {
              context
                  .read<InventoryItemsCubit>()
                  .fetchInventoryItems(search: query);
            },
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter ?? InventoryFilter.all;
              });
            },
          ),
        ),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading = state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.fetchList;
            final isError = state is InventoryItemsFailure &&
                state.action == InventoryItemsAction.fetchList;

            final items = state is InventoryItemsListSuccess
                ? _applyClientFilter(state.items)
                : DummyInventoryItems.items;

            if (isError) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              );
            }

            if (!isLoading && items.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No inventory items found.',
                    style: TextStyle(color: AppColors.mutedGray),
                  ),
                ),
              );
            }

            return Skeletonizer.sliver(
              enabled: isLoading,
              child: SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    .copyWith(bottom: 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InventoryItemCard(item: items[index]),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
            );
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

