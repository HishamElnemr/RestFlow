import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.hintText,
    this.prefixText,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.body1Medium16(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: AppStyles.body2Regular14(context),
          decoration: InputDecoration(
            hintText: hintText,
            prefixText: prefixText,
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
          validator: validator,
        ),
      ],
    );
  }
}
