import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../widgets/edit_inventory_item_page_body.dart';

class EditInventoryItemPage extends StatelessWidget {
  const EditInventoryItemPage({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<InventoryItemsCubit>()..fetchInventoryItemDetails(itemId),
        ),
        BlocProvider(
          create: (context) => getIt<InventoryCategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: EditInventoryItemPageBody(itemId: itemId),
        ),
      ),
    );
  }
}
