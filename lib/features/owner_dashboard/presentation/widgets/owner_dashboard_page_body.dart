import 'package:flutter/material.dart';
import 'package:rest_flow/features/customers/presentation/pages/customers_page.dart';
import 'package:rest_flow/features/products/presentation/pages/products_page.dart';
import 'package:rest_flow/features/employees/presentation/pages/employees_page.dart';

import '../../../../core/routes/routes_name.dart';
import 'dashboard_ai_insight_section.dart';
import 'dashboard_stat_cards_row.dart';
import 'owner_dashboard_header.dart';
import 'quick_access_grid.dart';
import 'recent_orders_list.dart';
import 'revenue_card.dart';


class OwnerDashboardPageBody extends StatelessWidget {
  const OwnerDashboardPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OwnerDashboardHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RevenueCard(),
                const SizedBox(height: 16),
                const DashboardStatCardsRow(),
                const SizedBox(height: 16),
                const DashboardAiInsightSection(),
                const SizedBox(height: 20),
                const RecentOrdersList(),
                const SizedBox(height: 24),
                QuickAccessGrid(
                  onProductsTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsPage()));
                  },
                  onCustomersTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomersPage()));
                  },
                  onInventoryTap: () {
                    Navigator.pushNamed(context, RoutesName.inventory);
                  },
                  onEmployeesTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeesPage()));
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
