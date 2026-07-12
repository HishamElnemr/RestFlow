import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:rest_flow/core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../widgets/menu_category_form_bottom_sheet.dart';
import '../widgets/menu_page_body.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCategoriesCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.backgroundLight,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              elevation: 0,
              title: Text(
                'Menu Categories',
                style: AppStyles.heading2SemiBold24(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              actions: const [
                SizedBox(width: 8),
              ],
            ),
            body: const SafeArea(
              child: MenuPageBody(),
            ),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'menu_page_fab',
              onPressed: () {
                MenuCategoryFormBottomSheet.show(context);
              },
              backgroundColor: AppColors.primary,
              icon: const Icon(LucideIcons.plus, color: AppColors.white),
              label: Text(
                'New Category',
                style: AppStyles.button2SemiBold14(context).copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
