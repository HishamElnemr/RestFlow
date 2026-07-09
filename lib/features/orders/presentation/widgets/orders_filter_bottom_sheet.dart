import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';

typedef FilterApplyCallback = void Function(
  PaymentStatus? paymentStatus,
  OrderType? orderType,
  String? fromDate,
  String? toDate,
);

class OrdersFilterBottomSheet extends StatefulWidget {
  const OrdersFilterBottomSheet({
    super.key,
    required this.selectedPaymentStatus,
    required this.selectedOrderType,
    required this.fromDate,
    required this.toDate,
    required this.onApply,
  });

  final PaymentStatus? selectedPaymentStatus;
  final OrderType? selectedOrderType;
  final String? fromDate;
  final String? toDate;
  final FilterApplyCallback onApply;

  @override
  State<OrdersFilterBottomSheet> createState() =>
      _OrdersFilterBottomSheetState();
}

class _OrdersFilterBottomSheetState extends State<OrdersFilterBottomSheet> {
  PaymentStatus? _paymentStatus;
  OrderType? _orderType;
  String? _fromDate;
  String? _toDate;

  @override
  void initState() {
    super.initState();
    _paymentStatus = widget.selectedPaymentStatus;
    _orderType = widget.selectedOrderType;
    _fromDate = widget.fromDate;
    _toDate = widget.toDate;
  }

  void _apply() {
    widget.onApply(_paymentStatus, _orderType, _fromDate, _toDate);
    Navigator.of(context).pop();
  }

  void _clearAll() {
    setState(() {
      _paymentStatus = null;
      _orderType = null;
      _fromDate = null;
      _toDate = null;
    });
    widget.onApply(null, null, null, null);
    Navigator.of(context).pop();
  }

  bool get _hasAny =>
      _paymentStatus != null ||
      _orderType != null ||
      _fromDate != null ||
      _toDate != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.warmGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'More Filters',
                  style: AppStyles.heading3SemiBold18(context).copyWith(
                    color: AppColors.darkNavy,
                  ),
                ),
                const Spacer(),
                if (_hasAny)
                  GestureDetector(
                    onTap: _clearAll,
                    child: Text(
                      'Clear all',
                      style: AppStyles.body2Medium14(context).copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Payment Status',
              style: AppStyles.body2Medium14(context).copyWith(
                color: AppColors.mutedGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _FilterOption(
            label: 'Paid',
            isSelected: _paymentStatus == PaymentStatus.paid,
            onTap: () => setState(() {
              _paymentStatus =
                  _paymentStatus == PaymentStatus.paid ? null : PaymentStatus.paid;
            }),
          ),
          _FilterOption(
            label: 'Unpaid',
            isSelected: _paymentStatus == PaymentStatus.unpaid,
            onTap: () => setState(() {
              _paymentStatus = _paymentStatus == PaymentStatus.unpaid
                  ? null
                  : PaymentStatus.unpaid;
            }),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Order Type',
              style: AppStyles.body2Medium14(context).copyWith(
                color: AppColors.mutedGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _FilterOption(
            label: 'Dine-in',
            isSelected: _orderType == OrderType.dineIn,
            onTap: () => setState(() {
              _orderType =
                  _orderType == OrderType.dineIn ? null : OrderType.dineIn;
            }),
          ),
          _FilterOption(
            label: 'Takeaway',
            isSelected: _orderType == OrderType.takeaway,
            onTap: () => setState(() {
              _orderType =
                  _orderType == OrderType.takeaway ? null : OrderType.takeaway;
            }),
          ),
          _FilterOption(
            label: 'Delivery',
            isSelected: _orderType == OrderType.delivery,
            onTap: () => setState(() {
              _orderType =
                  _orderType == OrderType.delivery ? null : OrderType.delivery;
            }),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _apply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Filters',
                  style: AppStyles.body2Medium14(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: AppStyles.body2Medium14(context).copyWith(
                color: isSelected ? AppColors.primary : AppColors.darkNavy,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primary : AppColors.warmGray,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 13)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
