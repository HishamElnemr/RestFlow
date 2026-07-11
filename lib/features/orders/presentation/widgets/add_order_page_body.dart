import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/domain/entities/product_list_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../customers/domain/entities/customer_entity.dart';
import '../../../customers/presentation/cubit/customers/customers_cubit.dart';
import '../../../customers/presentation/cubit/customers/customers_state.dart';
import '../../domain/entities/create_order_request_entity.dart';
import '../../domain/enums/order_type.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import 'order_form_fields.dart';
import 'order_item_selection_bottom_sheet.dart';
import '../../../../core/services/getit_services.dart';
import '../../../menu/presentation/cubit/menu_products/menu_products_cubit.dart';

class _AddedItem {
  final ProductListEntity product;
  final double quantity;

  _AddedItem({required this.product, required this.quantity});
}

class AddOrderPageBody extends StatefulWidget {
  const AddOrderPageBody({super.key});

  @override
  State<AddOrderPageBody> createState() => _AddOrderPageBodyState();
}

class _AddOrderPageBodyState extends State<AddOrderPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  OrderType? _selectedOrderType;
  String? _selectedCustomerId;
  List<CustomerEntity> _customers = [];
  final List<_AddedItem> _addedItems = [];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_addedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one item to the order'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final requestItems = _addedItems
        .map((e) => CreateOrderItemRequestEntity(
              productId: e.product.id,
              quantity: e.quantity,
            ))
        .toList();

    final request = CreateOrderRequestEntity(
      customerId: _selectedCustomerId,
      orderType: _selectedOrderType,
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      items: requestItems,
    );

    context.read<OrdersCubit>().createOrder(request);
  }

  void _showAddItemBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider(
          create: (_) => getIt<MenuProductsCubit>()..fetchProducts(),
          child: OrderItemSelectionBottomSheet(
            onItemSelected: (ProductListEntity product, double quantity) {
              setState(() {
                _addedItems.add(_AddedItem(product: product, quantity: quantity));
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CustomersCubit, CustomersState>(
          listener: (context, state) {
            if (state is CustomersListSuccess) {
              setState(() {
                _customers = state.customers;
              });
            } else if (state is CustomersFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Failed to load customers: ${state.failure.message}'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        ),
        BlocListener<OrdersCubit, OrdersState>(
          listener: (context, state) {
            if (state is OrdersError && state.action == OrdersAction.create) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: AppColors.error,
                ),
              );
            } else if (state is OrdersActionSuccess &&
                state.action == OrdersAction.create) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order created successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.pop(context, true);
            }
          },
        ),
      ],
      child: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Add New Order',
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderFormFields(
                    formKey: _formKey,
                    notesController: _notesController,
                    selectedOrderType: _selectedOrderType,
                    selectedCustomerId: _selectedCustomerId,
                    customers: _customers,
                    onOrderTypeChanged: (value) {
                      setState(() {
                        _selectedOrderType = value;
                      });
                    },
                    onCustomerChanged: (value) {
                      setState(() {
                        _selectedCustomerId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  _buildOrderItemsSection(context),
                  const SizedBox(height: 32),
                  BlocBuilder<OrdersCubit, OrdersState>(
                    builder: (context, state) {
                      final isLoading = state is OrdersLoading &&
                          state.action == OrdersAction.create;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Save Order',
                                  style:
                                      AppStyles.body1Medium16(context).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Items',
              style: AppStyles.body1SemiBold16(context),
            ),
            TextButton.icon(
              onPressed: _showAddItemBottomSheet,
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: Text(
                'Add Item',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_addedItems.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Text(
              'No items added yet.\nClick "Add Item" to add products.',
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
            itemCount: _addedItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = _addedItems[index];
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
                            item.product.productName,
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
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: AppColors.error),
                      onPressed: () {
                        setState(() {
                          _addedItems.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
