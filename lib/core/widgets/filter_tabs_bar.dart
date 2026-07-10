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
    this.isExpanded = false,
  });

  final List<FilterTabItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String allLabel;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        isExpanded
            ? Expanded(
                child: _FilterChip(
                  label: allLabel,
                  isSelected: selectedValue == null,
                  onTap: () => onChanged(null),
                  isExpanded: isExpanded,
                ),
              )
            : _FilterChip(
                label: allLabel,
                isSelected: selectedValue == null,
                onTap: () => onChanged(null),
                isExpanded: isExpanded,
              ),
        ...items.map(
          (item) => isExpanded
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterChip(
                      label: item.label,
                      isSelected: selectedValue == item.value,
                      onTap: () => onChanged(item.value),
                      isExpanded: isExpanded,
                      activeColor: item.activeColor,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _FilterChip(
                    label: item.label,
                    isSelected: selectedValue == item.value,
                    onTap: () => onChanged(item.value),
                    isExpanded: isExpanded,
                    activeColor: item.activeColor,
                  ),
                ),
        ),
      ],
    );

    return isExpanded
        ? row
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row,
          );
  }
}

class FilterTabItem<T> {
  const FilterTabItem({
    required this.label, 
    required this.value,
    this.activeColor,
  });

  final String label;
  final T value;
  final Color? activeColor;
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isExpanded = false,
    this.activeColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isExpanded;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    Color textColor = AppColors.mutedGray;
    Color bgColor = AppColors.white;
    Color borderColor = AppColors.warmGray;

    if (isSelected) {
      if (activeColor != null) {
        textColor = activeColor!;
        bgColor = AppColors.white;
        borderColor = activeColor!;
      } else {
        textColor = AppColors.white;
        bgColor = AppColors.primary;
        borderColor = AppColors.primary;
      }
    }

    Widget textWidget = FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        label,
        maxLines: 1,
        style: AppStyles.body2Medium14(context).copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    if (isExpanded) {
      textWidget = Center(child: textWidget);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 1.18,
          ),
        ),
        child: textWidget,
      ),
    );
  }
}
