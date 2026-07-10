import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomersSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CustomersSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppStyles.body2Medium14(context).copyWith(
        color: AppColors.darkNavy,
      ),
      decoration: InputDecoration(
        hintText: 'Search customers...',
        hintStyle: AppStyles.body2Medium14(context).copyWith(
          color: AppColors.mutedGray,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.mutedGray,
          size: 20,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.warmGray, width: 1.18),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.warmGray, width: 1.18),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.18),
        ),
      ),
    );
  }
}
