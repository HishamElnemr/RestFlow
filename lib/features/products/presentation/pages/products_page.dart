import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/products/presentation/pages/add_product_page.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/products/products_cubit.dart';
import '../widgets/products_page_body.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..fetchProducts(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: const SafeArea(
          child: ProductsPageBody(),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                final cubit = context.read<ProductsCubit>();
                Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: const AddProductPage(),
                    ),
                  ),
                ).then((didChange) {
                  log('[ProductsPage] Add page popped with result: $didChange');
                  if (didChange == true) {
                    cubit.fetchProducts();
                  }
                });
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            );
          }
        ),
      ),
    );
  }
}
