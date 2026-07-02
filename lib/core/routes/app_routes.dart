import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/auth_test_page.dart';
import '../../features/customers/presentation/pages/customers_test_page.dart';
import '../../features/inventory/presentation/pages/inventory_test_page.dart';
import '../../features/inventory/presentation/pages/low_stock_alerts_page.dart';
import '../../features/menu/presentation/pages/menu_orders_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
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
      case RoutesName.menuOrders:
        return MaterialPageRoute(
          builder: (_) => const MenuOrdersPage(),
          settings: settings,
        );
      case RoutesName.menu:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
          settings: settings,
        );
      case RoutesName.notificationSettings:
        return MaterialPageRoute(
          builder: (_) => const NotificationSettingsPage(),
          settings: settings,
        );
      case RoutesName.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
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
