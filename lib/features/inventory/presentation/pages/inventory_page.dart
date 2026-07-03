import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/services/getit_services.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../widgets/inventory_page_body.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryItemsCubit>()..fetchInventoryItems(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          title: const Text(
            'Inventory',
            style: TextStyle(
              color: AppColors.darkNavy,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.darkNavy),
        ),
        body: const SafeArea(
          child: InventoryPageBody(),
        ),
      ),
    );
  }
}
