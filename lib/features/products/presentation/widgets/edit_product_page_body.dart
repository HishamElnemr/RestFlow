import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/domain/entities/menu_category_list_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_products.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../menu/domain/entities/create_product_request_entity.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_cubit.dart';
import '../../../menu/presentation/cubit/menu_categories/menu_categories_state.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_state.dart';
import 'product_form_fields.dart';

class EditProductPageBody extends StatefulWidget {
  const EditProductPageBody({super.key, required this.productId});

  final String productId;

  @override
  State<EditProductPageBody> createState() => _EditProductPageBodyState();
}

class _EditProductPageBodyState extends State<EditProductPageBody> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  double? _price;
  bool? _isAvailable;
  String? _categoryId;
  String? _imageUrl;
  bool _isDataReady = false;

  @override
  void initState() {
    super.initState();
    log('[EditProductPageBody] initState: fetching details for ${widget.productId}');
    context.read<ProductsCubit>().fetchProductDetails(widget.productId);
  }

  void _tryResolveData(
      ProductsState productState, MenuCategoriesState catState) {
    if (_isDataReady) return;
    if (productState is! ProductDetailsLoaded) return;
    if (catState is! MenuCategoriesListSuccess) return;

    log('[EditProductPageBody] _tryResolveData: resolving data');
    log('[EditProductPageBody] product: ${productState.product.productName}, price: ${productState.product.sellingPrice}');

    _name = productState.product.productName;
    _price = productState.product.sellingPrice;
    _isAvailable = productState.product.isAvailable;
    _imageUrl = productState.product.imageUrl;

    try {
      _categoryId = catState.categories
          .firstWhere(
              (c) => c.categoryName == productState.product.categoryName)
          .id;
      log('[EditProductPageBody] matched categoryId: $_categoryId');
    } catch (_) {
      log('[EditProductPageBody] WARNING: could not match category "${productState.product.categoryName}"');
    }

    setState(() {
      _isDataReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        log('[EditProductPageBody] listener: state=${state.runtimeType}');
        if (state is ProductActionSuccess &&
            state.action == ProductsAction.update) {
          log('[EditProductPageBody] update SUCCESS -> popping with true');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product updated successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is ProductsFailure &&
            state.action == ProductsAction.update) {
          log('[EditProductPageBody] update FAILED: ${state.failure.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          log('[EditProductPageBody] ProductDetailsLoaded received in listener');
          final catState = context.read<MenuCategoriesCubit>().state;
          _tryResolveData(state, catState);
        }
      },
      builder: (context, state) {
        final isSaving =
            state is ProductsLoading && state.action == ProductsAction.update;

        if (state is ProductsFailure &&
            state.action == ProductsAction.fetchDetails) {
          return Center(
            child: Text('Failed to load product: ${state.failure.message}'),
          );
        }

        return BlocListener<MenuCategoriesCubit, MenuCategoriesState>(
          listener: (context, catState) {
            log('[EditProductPageBody] MenuCategoriesState changed: ${catState.runtimeType}');
            final productState = context.read<ProductsCubit>().state;
            _tryResolveData(productState, catState);
          },
          child: Skeletonizer(
            enabled: !_isDataReady,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      const CustomSliverAppBar(
                        title: 'Edit Product',
                        showBackButton: true,
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: Form(
                            key: _formKey,
                            child: ProductFormFields(
                              initialName: _isDataReady
                                  ? _name!
                                  : DummyProducts
                                      .dummyProducts.first.productName,
                              initialPrice: _isDataReady
                                  ? _price!
                                  : DummyProducts
                                      .dummyProducts.first.sellingPrice,
                              initialIsAvailable: _isDataReady
                                  ? _isAvailable!
                                  : DummyProducts
                                      .dummyProducts.first.isAvailable,
                              categories: context
                                          .read<MenuCategoriesCubit>()
                                          .state
                                      is MenuCategoriesListSuccess
                                  ? (context
                                              .read<MenuCategoriesCubit>()
                                              .state
                                          as MenuCategoriesListSuccess)
                                      .categories
                                  : <MenuCategoryListEntity>[],
                              initialCategoryId:
                                  _isDataReady ? _categoryId : null,
                              initialImageUrl: _isDataReady ? _imageUrl : null,
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
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSaving || !_isDataReady
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                log('[EditProductPageBody] Save pressed: name=$_name, price=$_price, categoryId=$_categoryId');
                                final request = CreateProductRequestEntity(
                                  productName: _name!,
                                  categoryId: _categoryId!,
                                  sellingPrice: _price!,
                                  isAvailable: _isAvailable!,
                                  imageUrl: _imageUrl,
                                  ingredients: const [],
                                );
                                context
                                    .read<ProductsCubit>()
                                    .updateProduct(widget.productId, request);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isSaving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Save Changes'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
