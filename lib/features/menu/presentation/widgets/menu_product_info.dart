import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/product_list_entity.dart';
import 'menu_product_availability_badge.dart';

class MenuProductInfo extends StatelessWidget {
  const MenuProductInfo({super.key, required this.product});

  final ProductListEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productName,
            style: AppStyles.body2Medium14(context).copyWith(
              color: AppColors.darkNavy,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            product.categoryName,
            style: AppStyles.captionRegular12(context).copyWith(
              color: AppColors.mutedGray,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.sellingPrice.toStringAsFixed(2)}',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
              MenuProductAvailabilityBadge(isAvailable: product.isAvailable),
            ],
          ),
        ],
      ),
    );
  }
}
