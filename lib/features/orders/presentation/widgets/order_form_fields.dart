import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../customers/domain/entities/customer_entity.dart';
import '../../domain/enums/order_type.dart';

class OrderFormFields extends StatelessWidget {
  const OrderFormFields({
    super.key,
    required this.formKey,
    required this.notesController,
    required this.selectedOrderType,
    required this.selectedCustomerId,
    required this.customers,
    required this.onOrderTypeChanged,
    required this.onCustomerChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController notesController;
  final OrderType? selectedOrderType;
  final String? selectedCustomerId;
  final List<CustomerEntity> customers;
  final ValueChanged<OrderType?> onOrderTypeChanged;
  final ValueChanged<String?> onCustomerChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerDropdown(context),
          const SizedBox(height: 20),
          _buildOrderTypeDropdown(context),
          const SizedBox(height: 20),
          _buildNotesField(context),
        ],
      ),
    );
  }

  Widget _buildCustomerDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer (Optional)',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: selectedCustomerId,
          onChanged: onCustomerChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.inputFocusedBorder,
                width: 1.5,
              ),
            ),
          ),
          hint: Text(
            'Select a customer',
            style: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.inputPlaceholder,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(
                'None',
                style: AppStyles.body2Regular14(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ...customers.map((customer) {
              return DropdownMenuItem(
                value: customer.id,
                child: Text(
                  customer.fullName,
                  style: AppStyles.body2Regular14(context).copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderTypeDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Type',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<OrderType>(
          initialValue: selectedOrderType,
          onChanged: onOrderTypeChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.inputFocusedBorder,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
          ),
          hint: Text(
            'Select order type',
            style: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.inputPlaceholder,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          validator: (value) {
            if (value == null) {
              return 'Please select an order type';
            }
            return null;
          },
          items: OrderType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(
                _formatOrderType(type),
                style: AppStyles.body2Regular14(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notesController,
          maxLines: 3,
          style: AppStyles.body2Regular14(context).copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'e.g. Extra spicy, no onions...',
            hintStyle: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.inputPlaceholder,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.inputFocusedBorder,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatOrderType(OrderType type) {
    switch (type) {
      case OrderType.dineIn:
        return 'Dine In';
      case OrderType.takeaway:
        return 'Takeaway';
      case OrderType.delivery:
        return 'Delivery';
    }
  }
}
