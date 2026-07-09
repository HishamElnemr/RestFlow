import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_products/menu_products_cubit.dart';
import '../cubit/menu_products/menu_products_state.dart';
import 'menu_product_card.dart';

class MenuProductGrid extends StatelessWidget {
  const MenuProductGrid({super.key, required this.selectedCategory});

  final MenuCategoryListEntity? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuProductsCubit, MenuProductsState>(
      builder: (context, state) {
        if (state is MenuProductsLoading || state is MenuProductsInitial) {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

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

        if (state is! MenuProductsListSuccess || state.products.isEmpty) {
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
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  MenuProductCard(product: state.products[index]),
              childCount: state.products.length,
            ),
          ),
        );
      },
    );
  }
}
