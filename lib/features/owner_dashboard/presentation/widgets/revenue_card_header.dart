import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class RevenueCardHeader extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const RevenueCardHeader({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Total Revenue',
            style: AppStyles.body2Medium14(context).copyWith(
              color: AppColors.whiteOpacity80,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            children: ['Today', 'Week', 'Month'].map((filter) {
              final isSelected = selectedFilter == filter;
              return GestureDetector(
                onTap: () => onFilterChanged(filter),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  child: Text(
                    filter,
                    style: AppStyles.captionSemiBold12(context).copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.whiteOpacity80,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
