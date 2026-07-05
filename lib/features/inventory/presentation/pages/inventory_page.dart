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
        body: const SafeArea(
          child: InventoryPageBody(),
        ),
      ),
    );
  }
}
