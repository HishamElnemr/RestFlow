import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _tabs = [
    'All (5)',
    'Pending (2)',
    'Completed (2)',
    'Cancelled (1)',
  ];

  final List<_OrderItem> _orders = [
    _OrderItem(
      orderNumber: '#ORD-1234',
      amount: '\$48.5',
      tags: ['Pickup', 'Pending', 'Unpaid'],
      details: '3 items',
      relativeTime: '2 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1233',
      amount: '\$125',
      tags: ['Delivery', 'Completed', 'Paid'],
      details: '5 items',
      relativeTime: '15 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1232',
      amount: '\$32.5',
      tags: ['Takeaway', 'Completed', 'Paid'],
      details: '2 items',
      relativeTime: '28 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1231',
      amount: '\$67',
      tags: ['In-Store', 'Pending', 'Unpaid'],
      details: '4 items',
      relativeTime: '35 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1230',
      amount: '\$88',
      tags: ['Delivery', 'Cancelled', 'Unpaid'],
      details: '6 items',
      relativeTime: '1 hour ago',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Orders',
                    style: AppStyles.heading2Bold24(context).copyWith(
                      color: AppColors.darkNavy,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.purple,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: const Text(
                      'Demo: Switch to Employee',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by order number...',
                        hintStyle: AppStyles.body2Regular14(context)
                            .copyWith(color: AppColors.mutedGray),
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list_rounded),
                      color: AppColors.darkNavy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedTab == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => setState(() => _selectedTab = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppColors.primary : AppColors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderLight,
                          ),
                        ),
                        child: Text(
                          _tabs[index],
                          style: AppStyles.body2Medium14(context).copyWith(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.darkNavy,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  itemCount: _orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = _orders[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkNavyOpacity50,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.orderNumber,
                                style: AppStyles.heading3SemiBold18(context)
                                    .copyWith(color: AppColors.darkNavy),
                              ),
                              Text(
                                order.amount,
                                style: AppStyles.heading3SemiBold18(context)
                                    .copyWith(color: AppColors.darkNavy),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: order.tags.map((tag) {
                              final tagColor = _statusColor(tag);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: tagColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tag,
                                  style: AppStyles.captionSemiBold12(context)
                                      .copyWith(color: tagColor),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.details,
                                style: AppStyles.body2Regular14(context)
                                    .copyWith(color: AppColors.mutedGray),
                              ),
                              Text(
                                order.relativeTime,
                                style: AppStyles.body2Regular14(context)
                                    .copyWith(color: AppColors.mutedGray),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Color _statusColor(String tag) {
    final lower = tag.toLowerCase();
    if (lower.contains('pending')) {
      return AppColors.amber;
    }
    if (lower.contains('completed') || lower.contains('paid')) {
      return AppColors.forestGreen;
    }
    if (lower.contains('cancelled')) {
      return AppColors.error;
    }
    if (lower.contains('pickup') ||
        lower.contains('delivery') ||
        lower.contains('takeaway')) {
      return AppColors.primary;
    }
    return AppColors.mutedGray;
  }
}

class _OrderItem {
  const _OrderItem({
    required this.orderNumber,
    required this.amount,
    required this.tags,
    required this.details,
    required this.relativeTime,
  });

  final String orderNumber;
  final String amount;
  final List<String> tags;
  final String details;
  final String relativeTime;
}
