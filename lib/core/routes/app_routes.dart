import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/auth_test_page.dart';
import '../../features/customers/presentation/pages/customers_test_page.dart';
import '../../features/inventory/presentation/pages/inventory_test_page.dart';
import '../../features/inventory/presentation/pages/low_stock_alerts_page.dart';
import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.authTest:
        return MaterialPageRoute(
          builder: (_) => const AuthTestPage(),
          settings: settings,
        );
      case RoutesName.customersTest:
        return MaterialPageRoute(
          builder: (_) => const CustomersTestPage(),
          settings: settings,
        );
      case RoutesName.inventoryTest:
        return MaterialPageRoute(
          builder: (_) => const InventoryTestPage(),
          settings: settings,
        );
      case RoutesName.lowStockAlerts:
        return MaterialPageRoute(
          builder: (_) => const LowStockAlertsPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AuthTestPage(),
          settings: settings,
        );
    }
  }
}
