import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../widgets/add_menu_category_page_body.dart';

class AddMenuCategoryPage extends StatelessWidget {
  const AddMenuCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCategoriesCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: AddMenuCategoryPageBody(),
        ),
      ),
    );
  }
}
