import 'package:flutter/material.dart';
import 'package:rest_flow/features/customers/presentation/pages/customers_page.dart';
import 'package:rest_flow/features/settings/presentation/pages/notification_settings_page.dart';

import '../../../../core/theme/app_colors.dart';
import 'more_list_item.dart';

class MoreListSection extends StatelessWidget {
  const MoreListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warmGray, width: 1.18),
      ),
      child: Column(
        children: [
          MoreListItem(
            icon: Icons.inventory_2_outlined,
            iconColor: AppColors.oliveGreen,
            title: 'Inventory',
            onTap: () {},
            showDivider: true,
          ),
          MoreListItem(
            icon: Icons.people_outline,
            iconColor: AppColors.electricBlue,
            title: 'Customers',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CustomersPage(),
                ),
              );
            },
            showDivider: true,
          ),
          MoreListItem(
            icon: Icons.badge_outlined,
            iconColor: AppColors.amber,
            title: 'Employees',
            onTap: () {},
            showDivider: true,
          ),
          MoreListItem(
            icon: Icons.bar_chart_outlined,
            iconColor: AppColors.error,
            title: 'Reports',
            onTap: () {},
            showDivider: true,
          ),
          MoreListItem(
            icon: Icons.notifications_none,
            iconColor: AppColors.electricBlue,
            title: 'Notifications',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsPage(),
                ),
              );
            },
            showDivider: true,
          ),
          MoreListItem(
            icon: Icons.settings_outlined,
            iconColor: AppColors.mutedGray,
            title: 'Settings',
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
