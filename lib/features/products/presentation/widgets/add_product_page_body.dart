import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/theme/app_colors.dart';
import 'package:rest_flow/features/menu/domain/entities/menu_category_list_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_menu.dart';
import '../../../menu/domain/entities/create_product_request_entity.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_cubit.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_state.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_state.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import 'product_form_fields.dart';
import 'product_save_button.dart';

class AddProductPageBody extends StatefulWidget {
  const AddProductPageBody({super.key});

  @override
  State<AddProductPageBody> createState() => _AddProductPageBodyState();
}

class _AddProductPageBodyState extends State<AddProductPageBody> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  bool _isAvailable = true;
  String? _categoryId;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        log('[AddProductPageBody] listener: state=${state.runtimeType}');
        if (state is ProductActionSuccess &&
            state.action == ProductsAction.create) {
          log('[AddProductPageBody] create SUCCESS -> popping with true');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is ProductsFailure &&
            state.action == ProductsAction.create) {
          log('[AddProductPageBody] create FAILED: ${state.failure.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isCreating =
            state is ProductsLoading && state.action == ProductsAction.create;

        return BlocBuilder<MenuCategoriesCubit, MenuCategoriesState>(
          builder: (context, catState) {
            final isCatsLoading = catState is MenuCategoriesLoading ||
                catState is MenuCategoriesInitial;
            final categories = catState is MenuCategoriesListSuccess
                ? catState.categories
                : <MenuCategoryListEntity>[];

            return Skeletonizer(
              enabled: isCatsLoading,
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        const CustomSliverAppBar(
                          title: 'Add Product',
                          showBackButton: true,
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            child: Form(
                              key: _formKey,
                              child: ProductFormFields(
                                initialName: _name,
                                initialPrice: _price,
                                initialIsAvailable: _isAvailable,
                                categories: isCatsLoading
                                    ? dummyMenuCategories
                                    : categories,
                                initialCategoryId: _categoryId,
                                onNameChanged: (val) => _name = val,
                                onPriceChanged: (val) =>
                                    _price = double.tryParse(val) ?? 0.0,
                                onAvailabilityChanged: (val) =>
                                    _isAvailable = val,
                                onCategoryChanged: (val) => _categoryId = val,
                                onImageChanged: (val) => _imageUrl = val,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      bottom: 32.0,
                    ),
                    child: ProductSaveButton(
                      label: 'Add Product',
                      isLoading: isCreating,
                      isDisabled: isCatsLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          log('[AddProductPageBody] Save pressed: name=$_name, price=$_price, categoryId=$_categoryId');
                          final request = CreateProductRequestEntity(
                            productName: _name,
                            categoryId: _categoryId!,
                            sellingPrice: _price,
                            isAvailable: _isAvailable,
                            imageUrl: _imageUrl,
                            ingredients: const [],
                          );
                          context.read<ProductsCubit>().createProduct(request);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
