import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../widgets/add_inventory_item_page_body.dart';

class AddInventoryItemPage extends StatelessWidget {
  const AddInventoryItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<InventoryItemsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<InventoryCategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: AddInventoryItemPageBody(),
        ),
      ),
    );
  }
}
