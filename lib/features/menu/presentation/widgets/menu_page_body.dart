import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_menu_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_categories/menu_categories_state.dart';
import 'menu_category_card.dart';
import 'menu_category_form_bottom_sheet.dart';

class MenuPageBody extends StatefulWidget {
  const MenuPageBody({super.key});

  @override
  State<MenuPageBody> createState() => _MenuPageBodyState();
}

class _MenuPageBodyState extends State<MenuPageBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuCategoriesCubit>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCategoriesCubit, MenuCategoriesState>(
      builder: (context, state) {
        final isLoading = state is MenuCategoriesInitial ||
            (state is MenuCategoriesLoading &&
                state.action == MenuCategoriesAction.fetchList);

        final hasError = state is MenuCategoriesFailure &&
            state.action == MenuCategoriesAction.fetchList;

        if (hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load categories',
                  style: AppStyles.heading3Medium22(context),
                ),
                const SizedBox(height: 8),
                Text(
                  (state as MenuCategoriesFailure).failure.message,
                  style: AppStyles.body2Regular14(context)
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () =>
                      context.read<MenuCategoriesCubit>().fetchCategories(),
                  icon: const Icon(LucideIcons.refresh_cw),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                ),
              ],
            ),
          );
        }

        List<MenuCategoryListEntity> categories = [];
        if (isLoading) {
          categories = dummyMenuCategories;
        } else if (state is MenuCategoriesListSuccess) {
          categories = state.categories;
        }

        if (!isLoading && categories.isEmpty) {
          return _buildEmptyState(context);
        }

        return Skeletonizer(
          enabled: isLoading,
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return MenuCategoryCard(
                category: category,
                onTap: () {
                  // Navigate to products list for this category
                },
                onEdit: () {
                  MenuCategoryFormBottomSheet.show(
                    context,
                    category: category,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.folder_open,
              color: AppColors.primary,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Categories Found',
            style: AppStyles.heading2SemiBold24(context),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first menu category to get started.',
            style: AppStyles.body1Regular16(context)
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              MenuCategoryFormBottomSheet.show(context);
            },
            icon: const Icon(LucideIcons.plus),
            label: const Text('Create Category'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
