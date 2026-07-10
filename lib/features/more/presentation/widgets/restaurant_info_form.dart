import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class RestaurantInfoForm extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nameController;
  final TextEditingController cuisineController;
  final TextEditingController countryController;
  final TextEditingController languageController;
  final TextEditingController timezoneController;
  final TextEditingController currencyController;

  const RestaurantInfoForm({
    super.key,
    required this.isEditing,
    required this.nameController,
    required this.cuisineController,
    required this.countryController,
    required this.languageController,
    required this.timezoneController,
    required this.currencyController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildField(context, 'Restaurant Name', nameController),
        const SizedBox(height: 16),
        _buildField(context, 'Cuisine Type', cuisineController),
        const SizedBox(height: 16),
        _buildField(context, 'Country', countryController),
        const SizedBox(height: 16),
        _buildField(context, 'Default Language', languageController),
        const SizedBox(height: 16),
        _buildField(context, 'Timezone', timezoneController),
        const SizedBox(height: 16),
        _buildField(context, 'Currency', currencyController),
      ],
    );
  }

  Widget _buildField(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.captionBold12(context).copyWith(
            color: AppColors.mutedGray,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditing,
          style: AppStyles.body2Medium14(context).copyWith(
            color: isEditing ? AppColors.darkNavy : AppColors.mutedGray,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isEditing ? AppColors.white : AppColors.backgroundLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isEditing ? AppColors.warmGray : Colors.transparent,
                width: 1.18,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.warmGray, width: 1.18),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.18),
            ),
          ),
        ),
      ],
    );
  }
}
