import 'package:rest_flow/features/ai/domain/entities/dashboard_insight_entity.dart';

class DummyAiDashboard {
  static const List<DashboardInsightEntity> insights = [
    DashboardInsightEntity(
      category: 'Inventory Depletion Forecast',
      insight: 'Your Margherita Pizza is running low and typically sells out by 6 PM on Mondays. Based on current stock (12 units) and average sales (18 units/day), you\'ll run out by 4:30 PM today. Consider increasing prep quantities by 50%.',
    ),
    DashboardInsightEntity(
      category: 'Menu Engineering Recommendation',
      insight: 'Customers who order Pasta Carbonara also order Garlic Bread 78% of the time. Creating a combo deal with 10% discount could increase average order value by \$8.50 and boost sales of both items.',
    ),
    DashboardInsightEntity(
      category: 'Daily Performance Summary',
      insight: 'Revenue is up 12.5% vs yesterday (\$12,485 vs \$11,100). Your top item today is Chicken Tikka Masala (32 orders). Busiest hour was 12:30-1:30 PM with 45 orders. Peak demand expected again at 7-8 PM.',
    ),
  ];
}
