import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_cubit.dart';
import '../widgets/add_product_page_body.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCategoriesCubit>()..fetchCategories(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: const SafeArea(
          child: AddProductPageBody(),
        ),
      ),
    );
  }
}
