import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../models/menu_product_model.dart';

class MenuProductCard extends StatelessWidget {
  const MenuProductCard({
    super.key,
    required this.product,
  });

  final MenuProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkNavyOpacity50,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.local_pizza_rounded,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            product.title,
            style: AppStyles.body1SemiBold16(context).copyWith(
              color: AppColors.darkNavy,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            product.subtitle,
            style: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.mutedGray,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.price,
                style: AppStyles.body1Medium16(context).copyWith(
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: product.status == 'Available'
                      ? AppColors.successBg
                      : AppColors.errorBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product.status.toUpperCase(),
                  style: AppStyles.captionSemiBold12(context).copyWith(
                    color: product.status == 'Available'
                        ? AppColors.successBright
                        : AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
