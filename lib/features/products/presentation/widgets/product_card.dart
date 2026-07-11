import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/products/presentation/pages/edit_product_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../menu/domain/entities/product_list_entity.dart';
import '../cubit/products/products_cubit.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductListEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<ProductsCubit>();
        Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: EditProductPage(productId: product.id),
            ),
          ),
        ).then((didChange) {
          log('[ProductCard] Edit page popped with result: $didChange');
          if (didChange == true) {
            cubit.fetchProducts();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.warmGray, width: 1.18),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              color: AppColors.surfaceLight,
              child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          _buildFallbackEmoji(),
                      placeholder: (context, url) => Skeletonizer(
                        child: Container(color: AppColors.borderLight),
                      ),
                    )
                  : _buildFallbackEmoji(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: AppStyles.body2Medium14(context).copyWith(
                        color: AppColors.darkNavy,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.categoryName,
                      style: AppStyles.captionRegular12(context)
                          .copyWith(color: AppColors.mutedGray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.sellingPrice.toStringAsFixed(2)}',
                          style: AppStyles.body2Medium14(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.electricBlue,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ProductsCubit>()
                                .changeProductAvailability(
                                  product.id,
                                  !product.isAvailable,
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: product.isAvailable
                                  ? const Color(0xFFEAF3DE)
                                  : const Color(0xFFF1EFE8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              product.isAvailable ? 'AVAILABLE' : 'UNAVAILABLE',
                              style:
                                  AppStyles.captionSemiBold12(context).copyWith(
                                letterSpacing: 0.275,
                                color: product.isAvailable
                                    ? AppColors.forestGreen
                                    : AppColors.mutedGray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackEmoji() {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: AppColors.borderLight,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            _getEmojiForCategory(product.categoryName),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }

  String _getEmojiForCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('pizza')) return '🍕';
    if (lower.contains('pasta')) return '🍝';
    if (lower.contains('salad')) return '🥗';
    if (lower.contains('burger')) return '🍔';
    if (lower.contains('drink')) return '🥤';
    return '🍽️';
  }
}
