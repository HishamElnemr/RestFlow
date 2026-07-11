import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_orders.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/order_list_entity.dart';
import '../../domain/entities/update_order_status_request_entity.dart';
import '../../domain/entities/update_payment_status_request_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/order_type.dart';
import '../../domain/enums/payment_status.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';

class EditOrderPageBody extends StatefulWidget {
  const EditOrderPageBody({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  State<EditOrderPageBody> createState() => _EditOrderPageBodyState();
}

class _EditOrderPageBodyState extends State<EditOrderPageBody> {
  OrderListEntity? _order;
  OrderStatus? _selectedOrderStatus;
  PaymentStatus? _selectedPaymentStatus;

  void _onSave() {
    bool hasChanges = false;
    
    if (_selectedOrderStatus != null &&
        _selectedOrderStatus != _order?.orderStatus) {
      context.read<OrdersCubit>().updateOrderStatus(
            widget.orderId,
            UpdateOrderStatusRequestEntity(status: _selectedOrderStatus),
          );
      hasChanges = true;
    }
    
    if (_selectedPaymentStatus != null &&
        _selectedPaymentStatus != _order?.paymentStatus) {
      context.read<OrdersCubit>().updatePaymentStatus(
            widget.orderId,
            UpdatePaymentStatusRequestEntity(status: _selectedPaymentStatus),
          );
      hasChanges = true;
    }

    if (!hasChanges) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrderDetailsSuccess) {
          setState(() {
            _order = state.order;
            _selectedOrderStatus = _order?.orderStatus;
            _selectedPaymentStatus = _order?.paymentStatus;
          });
        } else if (state is OrdersActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order updated successfully'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is OrdersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.failure.message}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoadingDetails = state is OrdersInitial ||
            (state is OrdersLoading &&
                state.action == OrdersAction.fetchById) ||
            _order == null;

        final isSaving = state is OrdersLoading &&
            (state.action == OrdersAction.updateStatus ||
                state.action == OrdersAction.updatePaymentStatus);

        final displayOrder = isLoadingDetails ? dummyOrders[0] : _order!;

        return Skeletonizer(
          enabled: isLoadingDetails,
          child: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(
                title: 'Order Details',
                showBackButton: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReadonlyInfo(context, displayOrder),
                      const SizedBox(height: 32),
                      _buildStatusDropdowns(context),
                      const SizedBox(height: 32),
                      _buildItemsList(context, displayOrder),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              (isLoadingDetails || isSaving) ? null : _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isSaving
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Save Changes',
                                  style:
                                      AppStyles.body1Medium16(context).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReadonlyInfo(BuildContext context, OrderListEntity order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID',
                style: AppStyles.body2Regular14(context).copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                order.orderNumber ?? 'N/A',
                style: AppStyles.body1Medium16(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Type',
                style: AppStyles.body2Regular14(context).copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                _formatOrderType(order.orderType),
                style: AppStyles.body2Medium14(context),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppStyles.body2Regular14(context).copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '\$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                style: AppStyles.body1SemiBold16(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdowns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<OrderStatus>(
          initialValue: _selectedOrderStatus,
          onChanged: (value) {
            setState(() {
              _selectedOrderStatus = value;
            });
          },
          decoration: _dropdownDecoration(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary),
          items: OrderStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(
                _formatOrderStatus(status),
                style: AppStyles.body2Regular14(context),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          'Payment Status',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<PaymentStatus>(
          initialValue: _selectedPaymentStatus,
          onChanged: (value) {
            setState(() {
              _selectedPaymentStatus = value;
            });
          },
          decoration: _dropdownDecoration(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary),
          items: PaymentStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(
                _formatPaymentStatus(status),
                style: AppStyles.body2Regular14(context),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildItemsList(BuildContext context, OrderListEntity order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Items',
          style: AppStyles.body1SemiBold16(context),
        ),
        const SizedBox(height: 16),
        if (order.items.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Text(
              'No items found.',
              textAlign: TextAlign.center,
              style: AppStyles.body2Regular14(context).copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.inputBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName ?? 'Unknown Product',
                            style: AppStyles.body1Medium16(context).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Qty: ${item.quantity}',
                            style: AppStyles.body2Regular14(context).copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${item.lineTotal?.toStringAsFixed(2) ?? '0.00'}',
                      style: AppStyles.body1Medium16(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
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
    );
  }

  String _formatOrderType(OrderType? type) {
    if (type == null) return 'N/A';
    switch (type) {
      case OrderType.dineIn:
        return 'Dine In';
      case OrderType.takeaway:
        return 'Takeaway';
      case OrderType.delivery:
        return 'Delivery';
    }
  }

  String _formatOrderStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';

      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _formatPaymentStatus(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.unpaid:
        return 'Unpaid';
      case PaymentStatus.paid:
        return 'Paid';
    }
  }
}
