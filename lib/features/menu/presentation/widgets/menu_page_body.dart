import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_products/menu_products_cubit.dart';
import 'menu_product_grid.dart';
import 'menu_sticky_header.dart';

class MenuPageBody extends StatefulWidget {
  const MenuPageBody({super.key});

  @override
  State<MenuPageBody> createState() => _MenuPageBodyState();
}

class _MenuPageBodyState extends State<MenuPageBody> {
  MenuCategoryListEntity? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<MenuCategoriesCubit>().fetchCategories();
    context.read<MenuProductsCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Menu',
          showBackButton: false,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _MenuStickyHeaderDelegate(
            height: 140.0,
            child: MenuStickyHeader(
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
              onSearchChanged: _onSearchChanged,
            ),
          ),
        ),
        MenuProductGrid(selectedCategory: _selectedCategory),
      ],
    );
  }

  void _onCategoryChanged(MenuCategoryListEntity? category) {
    setState(() => _selectedCategory = category);
    context.read<MenuProductsCubit>().fetchProducts(categoryId: category?.id);
  }

  void _onSearchChanged(String query) {
    context.read<MenuProductsCubit>().fetchProducts(
          search: query,
          categoryId: _selectedCategory?.id,
        );
  }
}

class _MenuStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _MenuStickyHeaderDelegate({required this.child, required this.height});

  final Widget child;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: AppColors.backgroundLight, child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _MenuStickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
