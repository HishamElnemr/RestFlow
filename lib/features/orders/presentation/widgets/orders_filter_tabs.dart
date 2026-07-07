import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/enums/order_status.dart';

class OrdersFilterTabs extends StatelessWidget {
  const OrdersFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  final OrderStatus? selectedStatus;
  final ValueChanged<OrderStatus?> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _TabItem(
            label: 'All',
            isSelected: selectedStatus == null,
            onTap: () => onStatusChanged(null),
          ),
          const SizedBox(width: 8),
          _TabItem(
            label: 'Pending',
            isSelected: selectedStatus == OrderStatus.pending,
            onTap: () => onStatusChanged(OrderStatus.pending),
          ),
          const SizedBox(width: 8),
          _TabItem(
            label: 'Completed',
            isSelected: selectedStatus == OrderStatus.completed,
            onTap: () => onStatusChanged(OrderStatus.completed),
          ),
          const SizedBox(width: 8),
          _TabItem(
            label: 'Cancelled',
            isSelected: selectedStatus == OrderStatus.cancelled,
            onTap: () => onStatusChanged(OrderStatus.cancelled),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
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
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.mutedGray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
