import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

enum ServiceType { dineIn, delivery, takeaway }

enum OrderStatus { pending, completed, cancelled }

enum PaymentStatus { paid, unpaid }

class OrderDemoData {
  final String orderNumber;
  final String amount;
  final ServiceType serviceType;
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final String itemCount;
  final String relativeTime;

  const OrderDemoData({
    required this.orderNumber,
    required this.amount,
    required this.serviceType,
    required this.status,
    required this.paymentStatus,
    required this.itemCount,
    required this.relativeTime,
  });
}

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.order,
    this.onTap,
  });

  final OrderDemoData order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Order Number & Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderNumber,
                  style: const TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  order.amount,
                  style: const TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Chips Wrap
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildServiceChip(),
                _buildStatusChip(),
                _buildPaymentChip(),
              ],
            ),
            const SizedBox(height: 14),
            // Bottom Row: Item Count & Relative Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.itemCount,
                  style: AppStyles.body2Regular14(context).copyWith(
                    color: AppColors.mutedGray,
                    fontSize: 12,
                  ),
                ),
                Text(
                  order.relativeTime,
                  style: AppStyles.body2Regular14(context).copyWith(
                    color: AppColors.mutedGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required Color bgColor,
    required Color textColor,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
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

  Widget _buildServiceChip() {
    switch (order.serviceType) {
      case ServiceType.dineIn:
        return _buildChip(
          label: 'Dine-in',
          bgColor: AppColors.primary.withOpacity(0.08),
          textColor: AppColors.primary,
          icon: Icons.restaurant_rounded,
        );
      case ServiceType.delivery:
        return _buildChip(
          label: 'Delivery',
          bgColor: AppColors.oliveGreenLight,
          textColor: AppColors.forestGreen,
          icon: Icons.local_shipping_rounded,
        );
      case ServiceType.takeaway:
        return _buildChip(
          label: 'Takeaway',
          bgColor: AppColors.warningBg,
          textColor: AppColors.amber,
          icon: Icons.shopping_bag_rounded,
        );
    }
  }

  Widget _buildStatusChip() {
    switch (order.status) {
      case OrderStatus.pending:
        return _buildChip(
          label: 'PENDING',
          bgColor: AppColors.warningBg,
          textColor: AppColors.amber,
        );
      case OrderStatus.completed:
        return _buildChip(
          label: 'COMPLETED',
          bgColor: AppColors.successBg,
          textColor: AppColors.successBright,
        );
      case OrderStatus.cancelled:
        return _buildChip(
          label: 'CANCELLED',
          bgColor: AppColors.errorBg,
          textColor: AppColors.error,
        );
    }
  }

  Widget _buildPaymentChip() {
    switch (order.paymentStatus) {
      case PaymentStatus.paid:
        return _buildChip(
          label: 'PAID',
          bgColor: AppColors.successBg,
          textColor: AppColors.successBright,
        );
      case PaymentStatus.unpaid:
        return _buildChip(
          label: 'UNPAID',
          bgColor: AppColors.surfaceLight,
          textColor: AppColors.mutedGray,
        );
    }
  }
}
