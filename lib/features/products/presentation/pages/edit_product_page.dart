import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/products/presentation/widgets/edit_product_page_body.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_cubit.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCategoriesCubit>()..fetchCategories(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: EditProductPageBody(productId: productId),
        ),
      ),
    );
  }
}
