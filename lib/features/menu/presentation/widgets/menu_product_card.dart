import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product_list_entity.dart';
import 'menu_product_image.dart';
import 'menu_product_info.dart';

class MenuProductCard extends StatelessWidget {
  const MenuProductCard({super.key, required this.product});

  final ProductListEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warmGray, width: 1.18),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MenuProductImage(),
          MenuProductInfo(product: product),
        ],
      ),
    );
  }
}
