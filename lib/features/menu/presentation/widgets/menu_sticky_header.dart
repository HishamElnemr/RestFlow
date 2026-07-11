import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_filter_button.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import 'menu_category_tabs.dart';

class MenuStickyHeader extends StatelessWidget {
  const MenuStickyHeader({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSearchChanged,
    required this.onFilterTap,
    required this.hasActiveFilters,
  });

  final MenuCategoryListEntity? selectedCategory;
  final ValueChanged<MenuCategoryListEntity?> onCategoryChanged;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  hintText: 'Search products...',
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
          const SizedBox(height: 12),
          MenuCategoryTabs(
            selectedCategory: selectedCategory,
            onCategoryChanged: onCategoryChanged,
          ),
        ],
      ),
    );
  }
}
