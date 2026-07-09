import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_products/menu_products_cubit.dart';
import '../widgets/menu_page_body.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MenuProductsCubit>()),
        BlocProvider(create: (_) => getIt<MenuCategoriesCubit>()),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(child: MenuPageBody()),
      ),
    );
  }
}
