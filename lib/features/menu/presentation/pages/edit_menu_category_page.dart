import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/services/getit_services.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../widgets/edit_menu_category_page_body.dart';
import '../../../menu/domain/entities/menu_category_list_entity.dart';

class EditMenuCategoryPage extends StatelessWidget {
  const EditMenuCategoryPage({
    super.key,
    required this.category,
  });

  final MenuCategoryListEntity category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCategoriesCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: EditMenuCategoryPageBody(category: category),
        ),
      ),
    );
  }
}
