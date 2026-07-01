import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({
    super.key,
    this.onOrdersTap,
    this.onMenuTap,
    this.onInventoryTap,
    this.onCustomersTap,
    this.onEmployeesTap,
    this.onReportsTap,
  });

  final VoidCallback? onOrdersTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onInventoryTap;
  final VoidCallback? onCustomersTap;
  final VoidCallback? onEmployeesTap;
  final VoidCallback? onReportsTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      _QuickAccessData(
        title: 'Orders',
        icon: Icons.shopping_cart_outlined,
        color: AppColors.primary,
        onTap: onOrdersTap,
      ),
      _QuickAccessData(
        title: 'Menu',
        icon: Icons.restaurant_menu_rounded,
        color: AppColors.orange,
        onTap: onMenuTap,
      ),
      _QuickAccessData(
        title: 'Inventory',
        icon: Icons.inventory_2_outlined,
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
        const Text(
          'Quick Access',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
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
            return InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: item.color,
                      size: 26,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
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
    required this.icon,
    required this.color,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
}
