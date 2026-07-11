import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class EmployeeTextField extends StatelessWidget {
  const EmployeeTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;

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
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: AppStyles.body2Regular14(context),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.mutedGray,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: true,
            fillColor: AppColors.surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
