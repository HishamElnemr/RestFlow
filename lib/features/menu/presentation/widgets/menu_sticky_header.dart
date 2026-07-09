import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import 'menu_category_tabs.dart';
import 'menu_search_bar.dart';

class MenuStickyHeader extends StatelessWidget {
  const MenuStickyHeader({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSearchChanged,
  });

  final MenuCategoryListEntity? selectedCategory;
  final ValueChanged<MenuCategoryListEntity?> onCategoryChanged;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          MenuSearchBar(onChanged: onSearchChanged),
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
