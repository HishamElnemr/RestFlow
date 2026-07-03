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
    return Column(
      children: [
        Padding(
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
        Expanded(
          child: BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
            builder: (context, state) {
              if (state is InventoryItemsLoading &&
                  state.action == InventoryItemsAction.fetchList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is InventoryItemsFailure &&
                  state.action == InventoryItemsAction.fetchList) {
                return Center(
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(color: AppColors.error),
                  ),
                );
              } else if (state is InventoryItemsListSuccess) {
                final filteredItems = _applyClientFilter(state.items);

                if (filteredItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'No inventory items found.',
                      style: TextStyle(color: AppColors.mutedGray),
                    ),
                  );
                }

                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                          .copyWith(bottom: 80),
                  itemCount: filteredItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return InventoryItemCard(item: filteredItems[index]);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
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
