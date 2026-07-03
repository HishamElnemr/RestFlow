import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum InventoryFilter { all, lowStock, outOfStock }

class InventoryFilterChips extends StatelessWidget {
  const InventoryFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final InventoryFilter selectedFilter;
  final ValueChanged<InventoryFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All Items',
            isSelected: selectedFilter == InventoryFilter.all,
            activeColor: AppColors.primary,
            onTap: () => onFilterChanged(InventoryFilter.all),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Low Stock',
            icon: Icons.warning_amber_rounded,
            isSelected: selectedFilter == InventoryFilter.lowStock,
            activeColor: AppColors.orange,
            onTap: () => onFilterChanged(InventoryFilter.lowStock),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Out of Stock',
            icon: Icons.error_outline_rounded,
            isSelected: selectedFilter == InventoryFilter.outOfStock,
            activeColor: AppColors.error,
            onTap: () => onFilterChanged(InventoryFilter.outOfStock),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.icon,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? activeColor : AppColors.borderLight,
            width: 1.18,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.white : activeColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : activeColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
