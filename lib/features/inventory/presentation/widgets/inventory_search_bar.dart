import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class InventorySearchBar extends StatelessWidget {
  const InventorySearchBar({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.18,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(
          color: AppColors.darkNavy,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        decoration: InputDecoration(
          hintText: 'Search inventory items...',
          hintStyle: TextStyle(
            color: AppColors.darkNavy.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'Inter',
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.darkNavy.withOpacity(0.5),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
