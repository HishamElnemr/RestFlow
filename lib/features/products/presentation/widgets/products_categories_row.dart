import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProductsCategoriesRow extends StatelessWidget {
  const ProductsCategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip(context, 'All Items (12)', true),
          const SizedBox(width: 8),
          _buildCategoryChip(context, 'Pizza (5)', false),
          const SizedBox(width: 8),
          _buildCategoryChip(context, 'Pasta (4)', false),
          const SizedBox(width: 8),
          _buildCategoryChip(context, 'Salads (3)', false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.electricBlue : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.electricBlue : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: isSelected
            ? AppStyles.body2Medium14(context).copyWith(color: AppColors.white)
            : AppStyles.body2Medium14(context).copyWith(color: AppColors.mutedGray),
      ),
    );
  }
}
