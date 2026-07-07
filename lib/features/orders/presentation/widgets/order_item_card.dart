import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/order_list_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';

class OrderItemCard extends StatelessWidget {
  final OrderListEntity order;

  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.warmGray,
          width: 1.18,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNumber != null
                          ? '#${order.orderNumber}'
                          : '#${order.id.substring(0, 8)}',
                      style: const TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        _OrderTypeBadge(type: order.orderType),
                        _OrderStatusBadge(status: order.orderStatus),
                        _PaymentStatusBadge(status: order.paymentStatus),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$${order.totalAmount?.toStringAsFixed(2) ?? "0.00"}',
                style: const TextStyle(
                  color: AppColors.darkNavy,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.warmGray, height: 1.18),
          const SizedBox(height: 12),
          Text(
            '${order.items.length} items',
            style: const TextStyle(
              color: AppColors.mutedGray,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTypeBadge extends StatelessWidget {
  final OrderType? type;

  const _OrderTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String label;

    switch (type) {
      case OrderType.takeaway:
        icon = Icons.takeout_dining_rounded;
        label = 'Takeaway';
        break;
      case OrderType.delivery:
        icon = Icons.delivery_dining_rounded;
        label = 'Delivery';
        break;
      case OrderType.dineIn:
      default:
        icon = Icons.restaurant_rounded;
        label = 'Dine-in';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // bg-[#eff6ff]
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.18,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  final OrderStatus? status;

  const _OrderStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case OrderStatus.completed:
        bgColor = AppColors.oliveGreenLight;
        textColor = AppColors.forestGreen;
        label = 'COMPLETED';
        break;
      case OrderStatus.cancelled:
        bgColor = AppColors.errorBg;
        textColor = AppColors.darkRed;
        label = 'CANCELLED';
        break;
      case OrderStatus.pending:
      default:
        bgColor = AppColors.cream;
        textColor = AppColors.darkOrange;
        label = 'PENDING';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.275,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _PaymentStatusBadge extends StatelessWidget {
  final PaymentStatus? status;

  const _PaymentStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case PaymentStatus.paid:
        bgColor = AppColors.oliveGreenLight;
        textColor = AppColors.forestGreen;
        label = 'PAID';
        break;
      case PaymentStatus.unpaid:
      default:
        bgColor = AppColors.ivory;
        textColor = AppColors.mutedGray;
        label = 'UNPAID';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.275,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
