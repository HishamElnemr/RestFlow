import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'quick_access_item_tile.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({
    super.key,
    this.onProductsTap,
    this.onMenuTap,
    this.onInventoryTap,
    this.onCustomersTap,
    this.onEmployeesTap,
    this.onReportsTap,
  });

  final VoidCallback? onProductsTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onInventoryTap;
  final VoidCallback? onCustomersTap;
  final VoidCallback? onEmployeesTap;
  final VoidCallback? onReportsTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      _QuickAccessData(
        title: 'Products',
        icon: Icons.fastfood_outlined,
        color: AppColors.primary,
        onTap: onProductsTap,
      ),
      _QuickAccessData(
        title: 'Menu',
        svgPath: 'assets/images/menu.svg',
        color: AppColors.orange,
        onTap: onMenuTap,
      ),
      _QuickAccessData(
        title: 'Inventory',
        svgPath: 'assets/images/onboarding3.svg',
        color: AppColors.oliveGreen,
        onTap: onInventoryTap,
      ),
      _QuickAccessData(
        title: 'Customers',
        icon: Icons.people_outline_rounded,
        color: AppColors.primaryLight,
        onTap: onCustomersTap,
      ),
      _QuickAccessData(
        title: 'Employees',
        icon: Icons.business_center_outlined,
        color: AppColors.amber,
        onTap: onEmployeesTap,
      ),
      _QuickAccessData(
        title: 'Reports',
        icon: Icons.bar_chart_rounded,
        color: AppColors.error,
        onTap: onReportsTap,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Access',
          style: AppStyles.body1Medium16(context).copyWith(
            color: AppColors.darkNavy,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return QuickAccessItemTile(
              title: item.title,
              icon: item.icon,
              svgPath: item.svgPath,
              color: item.color,
              onTap: item.onTap,
            );
          },
        ),
      ],
    );
  }
}

class _QuickAccessData {
  _QuickAccessData({
    required this.title,
    this.icon,
    this.svgPath,
    required this.color,
    this.onTap,
  });
  
  final String title;
  final IconData? icon;
  final String? svgPath;
  final Color color;
  final VoidCallback? onTap;
}
