import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../orders/domain/entities/order_list_entity.dart';
import '../../../orders/domain/enums/order_status.dart';
import '../../../orders/domain/enums/order_type.dart';
import '../../../orders/domain/enums/payment_status.dart';

class RecentOrderItemTile extends StatelessWidget {
  const RecentOrderItemTile({super.key, required this.order});

  final OrderListEntity order;

  @override
  Widget build(BuildContext context) {
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
                  order.orderNumber ?? '#ORD-UNKNOWN',
                  style: AppStyles.body2Medium14(context).copyWith(
                    color: AppColors.darkNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if (order.orderType != null)
                      _buildTypeChip(order.orderType!),
                    if (order.orderStatus != null)
                      _buildStatusChip(order.orderStatus!),
                    if (order.paymentStatus != null)
                      _buildPaymentChip(order.paymentStatus!),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Recently',
                style: AppStyles.captionRegular12(context).copyWith(
                  color: AppColors.mutedGray,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(OrderType type) {
    Color bgColor;
    Color textColor;
    IconData icon;
    String label;

    switch (type) {
      case OrderType.dineIn:
        bgColor = AppColors.primary.withOpacity(0.08);
        textColor = AppColors.primary;
        icon = Icons.restaurant_rounded;
        label = 'Dine-in';
        break;
      case OrderType.delivery:
        bgColor = AppColors.oliveGreenLight;
        textColor = AppColors.forestGreen;
        icon = Icons.local_shipping_rounded;
        label = 'Delivery';
        break;
      case OrderType.takeaway:
        bgColor = AppColors.warningBg;
        textColor = AppColors.amber;
        icon = Icons.shopping_bag_rounded;
        label = 'Takeaway';
        break;
    }

    return _OrderChip(
      label: label,
      bgColor: bgColor,
      textColor: textColor,
      icon: icon,
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color bgColor;
    Color textColor;
    String label = status.name.toUpperCase();

    switch (status) {
      case OrderStatus.pending:
        bgColor = AppColors.warningBg;
        textColor = AppColors.amber;
        break;
      case OrderStatus.completed:
        bgColor = AppColors.successBg;
        textColor = AppColors.successBright;
        break;
      case OrderStatus.cancelled:
        bgColor = AppColors.error.withOpacity(0.1);
        textColor = AppColors.error;
        break;
    }

    return _OrderChip(
      label: label,
      bgColor: bgColor,
      textColor: textColor,
    );
  }

  Widget _buildPaymentChip(PaymentStatus status) {
    Color bgColor;
    Color textColor;
    String label = status.name.toUpperCase();

    switch (status) {
      case PaymentStatus.paid:
        bgColor = AppColors.successBg;
        textColor = AppColors.successBright;
        break;
      case PaymentStatus.unpaid:
        bgColor = AppColors.surfaceLight;
        textColor = AppColors.mutedGray;
        break;
    }

    return _OrderChip(
      label: label,
      bgColor: bgColor,
      textColor: textColor,
    );
  }
}

class _OrderChip extends StatelessWidget {
  const _OrderChip({
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.icon,
  });

  final String label;
  final Color bgColor;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
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
            label,
            style: AppStyles.overlineSemiBold10(context).copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
