import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/app_styles.dart';

class FilterTabsBar<T> extends StatelessWidget {
  const FilterTabsBar({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.allLabel = 'All',
  });

  final List<FilterTabItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String allLabel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: allLabel,
            isSelected: selectedValue == null,
            onTap: () => onChanged(null),
          ),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _FilterChip(
                label: item.label,
                isSelected: selectedValue == item.value,
                onTap: () => onChanged(item.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterTabItem<T> {
  const FilterTabItem({required this.label, required this.value});

  final String label;
  final T value;
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.warmGray,
            width: 1.18,
          ),
        ),
        child: Text(
          label,
          style: AppStyles.body2Medium14(context).copyWith(
            color: isSelected ? AppColors.white : AppColors.mutedGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
