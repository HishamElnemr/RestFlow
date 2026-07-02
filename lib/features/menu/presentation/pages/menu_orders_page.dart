import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class MenuOrdersPage extends StatefulWidget {
  const MenuOrdersPage({super.key});

  @override
  State<MenuOrdersPage> createState() => _MenuOrdersPageState();
}

class _MenuOrdersPageState extends State<MenuOrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;

  final List<String> _tabs = [
    'All (5)',
    'Pending (2)',
    'Completed (2)',
    'Cancelled (1)',
  ];

  final List<_OrderItem> _orders = [
    _OrderItem(
      orderNumber: '#ORD-1234',
      tags: ['Pickup', 'Pending', 'Unpaid'],
      amount: '\$48.5',
      itemCount: '3 items',
      relativeTime: '2 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1233',
      tags: ['Delivery', 'Completed', 'Paid'],
      amount: '\$125',
      itemCount: '5 items',
      relativeTime: '15 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1232',
      tags: ['Takeaway', 'Completed', 'Paid'],
      amount: '\$32.5',
      itemCount: '2 items',
      relativeTime: '28 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1231',
      tags: ['In-Store', 'Pending', 'Unpaid'],
      amount: '\$67',
      itemCount: '4 items',
      relativeTime: '35 min ago',
    ),
    _OrderItem(
      orderNumber: '#ORD-1230',
      tags: ['Delivery', 'Cancelled', 'Unpaid'],
      amount: '\$0',
      itemCount: '0 items',
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
              const SizedBox(height: 20),
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
                      icon: const Icon(Icons.filter_list_rounded),
                      color: AppColors.darkNavy,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedTab;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
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
              const SizedBox(height: 20),
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
                            spreadRadius: 0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  order.orderNumber,
                                  style: AppStyles.heading3SemiBold18(context)
                                      .copyWith(color: AppColors.darkNavy),
                                ),
                              ),
                              Text(
                                order.amount,
                                style: AppStyles.heading3Bold18(context)
                                    .copyWith(color: AppColors.darkNavy),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: order.tags.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _tagColor(tag).withOpacity(0.14),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tag,
                                  style: AppStyles.captionSemiBold12(context)
                                      .copyWith(color: _tagColor(tag)),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.itemCount,
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
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Color _tagColor(String tag) {
    if (tag.toLowerCase().contains('pending')) {
      return AppColors.amber;
    }
    if (tag.toLowerCase().contains('completed') ||
        tag.toLowerCase().contains('paid')) {
      return AppColors.forestGreen;
    }
    if (tag.toLowerCase().contains('cancelled')) {
      return AppColors.error;
    }
    if (tag.toLowerCase().contains('pickup') ||
        tag.toLowerCase().contains('takeaway') ||
        tag.toLowerCase().contains('delivery')) {
      return AppColors.primary;
    }
    return AppColors.mutedGray;
  }
}

class _OrderItem {
  const _OrderItem({
    required this.orderNumber,
    required this.tags,
    required this.amount,
    required this.itemCount,
    required this.relativeTime,
  });

  final String orderNumber;
  final List<String> tags;
  final String amount;
  final String itemCount;
  final String relativeTime;
}
