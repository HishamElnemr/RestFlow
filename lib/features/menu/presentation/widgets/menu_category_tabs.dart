import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/filter_tabs_bar.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_categories/menu_categories_state.dart';

class MenuCategoryTabs extends StatelessWidget {
  const MenuCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final MenuCategoryListEntity? selectedCategory;
  final ValueChanged<MenuCategoryListEntity?> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCategoriesCubit, MenuCategoriesState>(
      builder: (context, state) {
        if (state is! MenuCategoriesListSuccess) {
          return const SizedBox.shrink();
        }
        return FilterTabsBar<MenuCategoryListEntity>(
          selectedValue: selectedCategory,
          onChanged: onCategoryChanged,
          items: state.categories
              .map((c) => FilterTabItem(label: c.categoryName, value: c))
              .toList(),
        );
      },
    );
  }
}
