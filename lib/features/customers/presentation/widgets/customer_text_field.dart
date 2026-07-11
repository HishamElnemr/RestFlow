import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomerTextField extends StatelessWidget {
  const CustomerTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.darkNavy,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.darkNavy,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.body2Medium14(context).copyWith(
              color: AppColors.mutedGray,
            ),
            filled: true,
            fillColor: AppColors.backgroundLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.warmGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.warmGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
