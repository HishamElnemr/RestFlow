import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RecentOrdersList extends StatelessWidget {
  const RecentOrdersList({super.key, this.onViewAllTap});

  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final orders = [
      _OrderDemoData(
        id: '#ORD-1234',
        price: '\$48.5',
        time: '2 min ago',
        chips: [
          _OrderChipData(label: 'Dine-in', type: _ChipType.dineIn),
          _OrderChipData(label: 'PENDING', type: _ChipType.pending),
          _OrderChipData(label: 'UNPAID', type: _ChipType.unpaid),
        ],
      ),
      _OrderDemoData(
        id: '#ORD-1233',
        price: '\$125',
        time: '15 min ago',
        chips: [
          _OrderChipData(label: 'Delivery', type: _ChipType.delivery),
          _OrderChipData(label: 'COMPLETED', type: _ChipType.completed),
          _OrderChipData(label: 'PAID', type: _ChipType.paid),
        ],
      ),
      _OrderDemoData(
        id: '#ORD-1232',
        price: '\$32.5',
        time: '28 min ago',
        chips: [
          _OrderChipData(label: 'Takeaway', type: _ChipType.takeaway),
          _OrderChipData(label: 'COMPLETED', type: _ChipType.completed),
          _OrderChipData(label: 'PAID', type: _ChipType.paid),
        ],
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllTap,
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: AppColors.borderLight,
            ),
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.id,
                            style: const TextStyle(
                              color: AppColors.darkNavy,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: order.chips.map((chip) {
                              return _buildChip(chip);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          order.price,
                          style: const TextStyle(
                            color: AppColors.darkNavy,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.time,
                          style: const TextStyle(
                            color: AppColors.mutedGray,
                            fontSize: 11,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChip(_OrderChipData chip) {
    Color bgColor;
    Color textColor;
    IconData? icon;

    switch (chip.type) {
      case _ChipType.dineIn:
        bgColor = AppColors.primary.withOpacity(0.08);
        textColor = AppColors.primary;
        icon = Icons.restaurant_rounded;
        break;
      case _ChipType.delivery:
        bgColor = AppColors.oliveGreenLight;
        textColor = AppColors.forestGreen;
        icon = Icons.local_shipping_rounded;
        break;
      case _ChipType.takeaway:
        bgColor = AppColors.warningBg;
        textColor = AppColors.amber;
        icon = Icons.shopping_bag_rounded;
        break;
      case _ChipType.pending:
        bgColor = AppColors.warningBg;
        textColor = AppColors.amber;
        break;
      case _ChipType.completed:
      case _ChipType.paid:
        bgColor = AppColors.successBg;
        textColor = AppColors.successBright;
        break;
      case _ChipType.unpaid:
        bgColor = AppColors.surfaceLight;
        textColor = AppColors.mutedGray;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            chip.label,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

enum _ChipType {
  dineIn,
  delivery,
  takeaway,
  pending,
  completed,
  paid,
  unpaid,
}

class _OrderChipData {
  _OrderChipData({required this.label, required this.type});
  final String label;
  final _ChipType type;
}

class _OrderDemoData {
  _OrderDemoData({
    required this.id,
    required this.price,
    required this.time,
    required this.chips,
  });
  final String id;
  final String price;
  final String time;
  final List<_OrderChipData> chips;
}
