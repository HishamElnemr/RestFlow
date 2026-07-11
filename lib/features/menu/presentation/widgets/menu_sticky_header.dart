import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_categories/menu_categories_cubit.dart';
import 'package:rest_flow/features/menu/presentation/pages/edit_menu_category_page.dart';

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
          Row(
            children: [
              Expanded(
                child: MenuCategoryTabs(
                  selectedCategory: selectedCategory,
                  onCategoryChanged: onCategoryChanged,
                ),
              ),
              if (selectedCategory != null) ...[
                const SizedBox(width: 8),
                Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (_) => EditMenuCategoryPage(
                            category: selectedCategory!,
                          ),
                        ),
                      )
                          .then((result) {
                        if (result == true) {
                          context.read<MenuCategoriesCubit>().fetchCategories();
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderLight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.electricBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
