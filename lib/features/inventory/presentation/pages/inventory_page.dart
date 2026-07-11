import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../widgets/inventory_page_body.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<InventoryItemsCubit>()..fetchInventoryItems(),
        ),
        BlocProvider(
          create: (_) => getIt<InventoryCategoriesCubit>(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: InventoryPageBody(),
        ),
      ),
    );
  }
}
