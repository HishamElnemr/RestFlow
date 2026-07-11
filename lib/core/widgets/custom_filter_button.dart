import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({
    super.key,
    required this.hasActiveFilters,
    required this.onTap,
  });

  final bool hasActiveFilters;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 47.984,
            height: 47.984,
            decoration: BoxDecoration(
              color: hasActiveFilters ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    hasActiveFilters ? AppColors.primary : AppColors.borderLight,
                width: 1.18,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.tune_rounded,
                color: hasActiveFilters ? AppColors.white : AppColors.darkNavy,
                size: 20,
              ),
            ),
          ),
          if (hasActiveFilters)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
