import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'order_card_widget.dart';
import 'order_search_bar.dart';
import 'orders_filter_tabs.dart';
import 'orders_header.dart';

class OrdersPageBody extends StatefulWidget {
  const OrdersPageBody({super.key});

  @override
  State<OrdersPageBody> createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _searchQuery = '';

  final List<OrderDemoData> _orders = const [
    OrderDemoData(
      orderNumber: '#ORD-1234',
      amount: '\$48.5',
      serviceType: ServiceType.dineIn,
      status: OrderStatus.pending,
      paymentStatus: PaymentStatus.unpaid,
      itemCount: '3 items',
      relativeTime: '2 min ago',
    ),
    OrderDemoData(
      orderNumber: '#ORD-1233',
      amount: '\$125',
      serviceType: ServiceType.delivery,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paid,
      itemCount: '5 items',
      relativeTime: '15 min ago',
    ),
    OrderDemoData(
      orderNumber: '#ORD-1232',
      amount: '\$32.5',
      serviceType: ServiceType.takeaway,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paid,
      itemCount: '2 items',
      relativeTime: '28 min ago',
    ),
    OrderDemoData(
      orderNumber: '#ORD-1231',
      amount: '\$67',
      serviceType: ServiceType.dineIn,
      status: OrderStatus.pending,
      paymentStatus: PaymentStatus.unpaid,
      itemCount: '4 items',
      relativeTime: '35 min ago',
    ),
    OrderDemoData(
      orderNumber: '#ORD-1230',
      amount: '\$95',
      serviceType: ServiceType.delivery,
      status: OrderStatus.cancelled,
      paymentStatus: PaymentStatus.unpaid,
      itemCount: '6 items',
      relativeTime: '1 hour ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<OrderDemoData> get _filteredOrders {
    return _orders.where((order) {
      // Filter by category tab
      bool matchesTab = false;
      switch (_selectedTab) {
        case 0: // All
          matchesTab = true;
          break;
        case 1: // Pending
          matchesTab = order.status == OrderStatus.pending;
          break;
        case 2: // Completed
          matchesTab = order.status == OrderStatus.completed;
          break;
        case 3: // Cancelled
          matchesTab = order.status == OrderStatus.cancelled;
          break;
      }

      // Filter by search query
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        matchesSearch = order.orderNumber
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
      }

      return matchesTab && matchesSearch;
    }).toList();
  }

  List<String> get _tabs {
    final allCount = _orders.length;
    final pendingCount = _orders.where((o) => o.status == OrderStatus.pending).length;
    final completedCount = _orders.where((o) => o.status == OrderStatus.completed).length;
    final cancelledCount = _orders.where((o) => o.status == OrderStatus.cancelled).length;

    return [
      'All ($allCount)',
      'Pending ($pendingCount)',
      'Completed ($completedCount)',
      'Cancelled ($cancelledCount)',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredOrders;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrdersHeader(),
          const SizedBox(height: 20),
          OrderSearchBar(
            controller: _searchController,
          ),
          const SizedBox(height: 16),
          OrdersFilterTabs(
            tabs: _tabs,
            selectedIndex: _selectedTab,
            onTabSelected: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredList.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: filteredList.length,
                    padding: const EdgeInsets.only(bottom: 80), // extra padding for FAB
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return OrderCardWidget(
                        order: filteredList[index],
                        onTap: () {
                          // Handle details view if needed later
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 64,
            color: AppColors.mutedGray.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: TextStyle(
              color: AppColors.darkNavy.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your search query or category filter',
            style: TextStyle(
              color: AppColors.mutedGray.withOpacity(0.8),
              fontSize: 13,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
