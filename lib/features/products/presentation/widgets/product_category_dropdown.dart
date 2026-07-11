import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../menu/domain/entities/menu_category_list_entity.dart';

class ProductCategoryDropdown extends StatelessWidget {
  const ProductCategoryDropdown({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final List<MenuCategoryListEntity> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppStyles.body1Medium16(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: selectedCategoryId,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.mutedGray),
          style: AppStyles.body2Regular14(context).copyWith(
            color: AppColors.darkNavy,
          ),
          items: categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat.id,
              child: Text(cat.categoryName),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Select a category',
            hintStyle: AppStyles.body2Regular14(context)
                .copyWith(color: AppColors.mutedGray),
            filled: true,
            fillColor: AppColors.surfaceLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.electricBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
          validator: (val) => val == null ? 'Please select a category' : null,
        ),
      ],
    );
  }
}
