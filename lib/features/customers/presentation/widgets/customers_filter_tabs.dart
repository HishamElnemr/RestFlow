import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/customer_status.dart';

class CustomersFilterTabs extends StatelessWidget {
  final CustomerStatus? selectedStatus;
  final ValueChanged<CustomerStatus?> onStatusChanged;

  const CustomersFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTab(context, 'All', null),
          const SizedBox(width: 8),
          _buildTab(context, 'Active', CustomerStatus.active),
          const SizedBox(width: 8),
          _buildTab(context, 'Inactive', CustomerStatus.inactive),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, CustomerStatus? status) {
    final isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => onStatusChanged(status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkNavy : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.darkNavy : AppColors.warmGray,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppStyles.body2Medium14(context).copyWith(
            color: isSelected ? AppColors.white : AppColors.mutedGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
