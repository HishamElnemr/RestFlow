import 'package:flutter/material.dart';
import 'package:rest_flow/features/inventory/presentation/widgets/inventory_filter_chips.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_filter_button.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../../core/widgets/filter_tabs_bar.dart';

class InventoryStickyHeader extends SliverPersistentHeaderDelegate {
  InventoryStickyHeader({
    required this.height,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onFilterTap,
    required this.hasActiveFilters,
  });

  final double height;
  final InventoryFilter selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<InventoryFilter?> onFilterChanged;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    hintText: 'Search inventory...',
                    onChanged: onSearchChanged,
                  ),
                ),
                const SizedBox(width: 12),
                CustomFilterButton(
                  onTap: onFilterTap,
                  hasActiveFilters: hasActiveFilters,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilterTabsBar<InventoryFilter>(
              items: const [
                FilterTabItem(
                  label: 'Low Stock',
                  value: InventoryFilter.lowStock,
                  activeColor: AppColors.amber,
                ),
                FilterTabItem(
                  label: 'Out of Stock',
                  value: InventoryFilter.outOfStock,
                  activeColor: AppColors.error,
                ),
              ],
              selectedValue:
                  selectedFilter == InventoryFilter.all ? null : selectedFilter,
              onChanged: onFilterChanged,
              allLabel: 'All',
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant InventoryStickyHeader oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.selectedFilter != selectedFilter;
  }
}
