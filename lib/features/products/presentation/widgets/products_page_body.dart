import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_products.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../core/widgets/custom_filter_button.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_state.dart';
import '../../../../features/menu/domain/entities/product_list_entity.dart';
import 'product_card.dart';
import 'products_filter_bottom_sheet.dart';

class ProductsPageBody extends StatefulWidget {
  const ProductsPageBody({super.key});

  @override
  State<ProductsPageBody> createState() => _ProductsPageBodyState();
}

class _ProductsPageBodyState extends State<ProductsPageBody> {
  bool? _filterIsAvailable;
  double? _filterMinPrice;
  double? _filterMaxPrice;

  List<ProductListEntity> _products = [];
  bool _isFirstLoad = true;

  bool get _hasActiveFilters =>
      _filterIsAvailable != null ||
      _filterMinPrice != null ||
      _filterMaxPrice != null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        log('[ProductsPageBody] listener: state=${state.runtimeType}');
        if (state is ProductActionSuccess &&
            state.action == ProductsAction.changeAvailability) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Availability updated successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          context.read<ProductsCubit>().fetchProducts();
        } else if (state is ProductsFailure &&
            state.action == ProductsAction.fetchAll) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isFetching = state is ProductsLoading &&
            state.action == ProductsAction.fetchAll;

        if (state is ProductsListLoaded) {
          log('[ProductsPageBody] builder: ProductsListLoaded with ${state.products.length} products');
          _products = state.products;
          _isFirstLoad = false;
        }

        final isLoading = _isFirstLoad && isFetching;

        var displayProducts = isLoading ? DummyProducts.dummyProducts : _products;

        if (!isLoading) {
          displayProducts = displayProducts.where((p) {
            if (_filterIsAvailable != null && p.isAvailable != _filterIsAvailable) {
              return false;
            }
            if (_filterMinPrice != null && p.sellingPrice < _filterMinPrice!) {
              return false;
            }
            if (_filterMaxPrice != null && p.sellingPrice > _filterMaxPrice!) {
              return false;
            }
            return true;
          }).toList();
        }

        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: 'Products',
              showBackButton: true,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProductsStickyHeaderDelegate(
                height: 80.0,
                child: Container(
                  color: AppColors.backgroundLight,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          hintText: 'Search products...',
                          onChanged: (query) {
                            context.read<ProductsCubit>().fetchProducts(search: query);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomFilterButton(
                        hasActiveFilters: _hasActiveFilters,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => ProductsFilterBottomSheet(
                              selectedIsAvailable: _filterIsAvailable,
                              minPrice: _filterMinPrice,
                              maxPrice: _filterMaxPrice,
                              onApply: (isAvailable, minPrice, maxPrice) {
                                setState(() {
                                  _filterIsAvailable = isAvailable;
                                  _filterMinPrice = minPrice;
                                  _filterMaxPrice = maxPrice;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is ProductsFailure && state.action == ProductsAction.fetchAll)
              SliverFillRemaining(
                child: Center(
                  child: Text('Error: ${state.failure.message}'),
                ),
              )
            else if (!isLoading && displayProducts.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text('No products found matching filters.'),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: Skeletonizer.sliver(
                  enabled: isLoading,
                  child: SliverList.separated(
                    itemCount: displayProducts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return ProductCard(product: displayProducts[index]);
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ProductsStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ProductsStickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _ProductsStickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
