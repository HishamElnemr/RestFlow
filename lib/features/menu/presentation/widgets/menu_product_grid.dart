import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/dummy_data/dummy_menu.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../../domain/entities/product_list_entity.dart';
import '../cubit/menu_products/menu_products_cubit.dart';
import '../cubit/menu_products/menu_products_state.dart';
import 'menu_product_card.dart';

class MenuProductGrid extends StatelessWidget {
  const MenuProductGrid({
    super.key, 
    required this.selectedCategory,
    this.filterIsAvailable,
    this.filterMinPrice,
    this.filterMaxPrice,
  });

  final MenuCategoryListEntity? selectedCategory;
  final bool? filterIsAvailable;
  final double? filterMinPrice;
  final double? filterMaxPrice;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuProductsCubit, MenuProductsState>(
      builder: (context, state) {
        final isLoading = state is MenuProductsLoading || state is MenuProductsInitial;

        if (state is MenuProductsFailure) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                state.failure.message,
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          );
        }

        var products = state is MenuProductsListSuccess 
            ? state.products 
            : (isLoading ? dummyMenuProducts : <ProductListEntity>[]);

        if (!isLoading) {
          products = products.where((p) {
            if (filterIsAvailable != null && p.isAvailable != filterIsAvailable) {
              return false;
            }
            if (filterMinPrice != null && p.sellingPrice < filterMinPrice!) {
              return false;
            }
            if (filterMaxPrice != null && p.sellingPrice > filterMaxPrice!) {
              return false;
            }
            return true;
          }).toList();
        }

        if (!isLoading && products.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                'No products found.',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
              .copyWith(bottom: 96),
          sliver: Skeletonizer.sliver(
            enabled: isLoading,
            child: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    MenuProductCard(product: products[index]),
                childCount: products.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
