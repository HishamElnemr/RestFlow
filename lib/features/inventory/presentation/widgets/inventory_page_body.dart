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
import '../pages/add_inventory_item_page.dart';
import '../pages/edit_inventory_item_page.dart';
import 'inventory_filter_bottom_sheet.dart';
import 'inventory_item_card.dart';
import 'inventory_sticky_header.dart';

class InventoryPageBody extends StatefulWidget {
  const InventoryPageBody({super.key});

  @override
  State<InventoryPageBody> createState() => _InventoryPageBodyState();
}

class _InventoryPageBodyState extends State<InventoryPageBody> {
  InventoryFilter _selectedFilter = InventoryFilter.all;
  String? _selectedCategoryId;
  double? _filterMinQ;
  double? _filterMaxQ;
  double? _filterMinCost;
  double? _filterMaxCost;
  String _currentSearchQuery = '';

  void _refresh() {
    context
        .read<InventoryItemsCubit>()
        .fetchInventoryItems(search: _currentSearchQuery.isEmpty ? null : _currentSearchQuery, categoryId: _selectedCategoryId); // Actually tab filter is handled client side
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return InventoryFilterBottomSheet(
          selectedCategoryId: _selectedCategoryId,
          minQuantity: _filterMinQ,
          maxQuantity: _filterMaxQ,
          minCost: _filterMinCost,
          maxCost: _filterMaxCost,
          onApply: (categoryId, minQ, maxQ, minCost, maxCost) {
            setState(() {
              _selectedCategoryId = categoryId;
              _filterMinQ = minQ;
              _filterMaxQ = maxQ;
              _filterMinCost = minCost;
              _filterMaxCost = maxCost;
            });
            _refresh();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddInventoryItemPage(),
            ),
          ).then((value) {
            if (value == true) {
              _refresh();
            }
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: 'Inventory'),
        SliverPersistentHeader(
          pinned: true,
          delegate: InventoryStickyHeader(
            height: 152.0,
            selectedFilter: _selectedFilter,
            hasActiveFilters: _selectedCategoryId != null ||
                _filterMinQ != null ||
                _filterMaxQ != null ||
                _filterMinCost != null ||
                _filterMaxCost != null,
            onFilterTap: _showFilterBottomSheet,
            onSearchChanged: (query) {
              _currentSearchQuery = query;
              _refresh();
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
                        child: InventoryItemCard(
                          item: items[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditInventoryItemPage(
                                  itemId: items[index].id,
                                ),
                              ),
                            ).then((value) {
                              if (value == true) {
                                _refresh();
                              }
                            });
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditInventoryItemPage(
                                  itemId: items[index].id,
                                ),
                              ),
                            ).then((value) {
                              if (value == true) {
                                _refresh();
                              }
                            });
                          },
                        ),
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
    ),
    );
  }

  List<InventoryItemListEntity> _applyClientFilter(
      List<InventoryItemListEntity> items) {
    List<InventoryItemListEntity> filtered = items;

    if (_selectedFilter == InventoryFilter.lowStock) {
      filtered = filtered
          .where((item) =>
              item.currentQuantity <= item.minimumQuantity &&
              item.currentQuantity > 0)
          .toList();
    } else if (_selectedFilter == InventoryFilter.outOfStock) {
      filtered = filtered.where((item) => item.currentQuantity == 0).toList();
    }

    if (_filterMinQ != null) {
      filtered = filtered.where((item) => item.currentQuantity >= _filterMinQ!).toList();
    }
    if (_filterMaxQ != null) {
      filtered = filtered.where((item) => item.currentQuantity <= _filterMaxQ!).toList();
    }
    if (_filterMinCost != null) {
      filtered = filtered.where((item) => item.costPerUnit >= _filterMinCost!).toList();
    }
    if (_filterMaxCost != null) {
      filtered = filtered.where((item) => item.costPerUnit <= _filterMaxCost!).toList();
    }

    return filtered;
  }
}

