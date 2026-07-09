import 'package:flutter/material.dart';
import '../../../../core/routes/routes_name.dart';
import 'dashboard_ai_insight_section.dart';
import 'dashboard_stat_cards_row.dart';
import 'owner_dashboard_header.dart';
import 'owner_dashboard_notifications_widget.dart';
import 'quick_access_grid.dart';
import 'recent_orders_list.dart';
import 'revenue_card.dart';

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
          const DashboardStatCardsRow(),
          const SizedBox(height: 16),
          const DashboardAiInsightSection(),
          const SizedBox(height: 20),
          const OwnerDashboardNotificationsWidget(),
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
