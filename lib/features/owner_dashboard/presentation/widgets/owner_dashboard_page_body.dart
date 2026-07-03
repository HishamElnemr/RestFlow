import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'ai_insight_card.dart';
import 'owner_dashboard_header.dart';
import '../../../../core/routes/routes_name.dart';
import 'quick_access_grid.dart';
import 'recent_orders_list.dart';
import 'revenue_card.dart';
import 'stat_card.dart';

class OwnerDashboardPageBody extends StatelessWidget {
  const OwnerDashboardPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OwnerDashboardHeader(),
          const SizedBox(height: 20),
          const RevenueCard(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Total Orders',
                  value: '248',
                  iconColor: AppColors.primary,
                  iconBgColor: AppColors.primary.withOpacity(0.08),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  icon: Icons.inventory_2_outlined,
                  title: 'Active Products',
                  value: '86',
                  iconColor: AppColors.oliveGreen,
                  iconBgColor: AppColors.oliveGreenLight,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  icon: Icons.warning_amber_rounded,
                  title: 'Low Stock',
                  value: '5',
                  iconColor: AppColors.orange,
                  iconBgColor: AppColors.warningBg,
                  borderColor: AppColors.orange.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AiInsightCard(),
          const SizedBox(height: 20),
          const RecentOrdersList(),
          const SizedBox(height: 24),
          QuickAccessGrid(
            onInventoryTap: () {
              Navigator.pushNamed(context, RoutesName.inventory);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
