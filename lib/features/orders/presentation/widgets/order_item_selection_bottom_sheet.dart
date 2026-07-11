import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/menu/domain/entities/product_list_entity.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_cubit.dart';
import 'package:rest_flow/features/menu/presentation/cubit/menu_products/menu_products_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OrderItemSelectionBottomSheet extends StatefulWidget {
  const OrderItemSelectionBottomSheet({
    super.key,
    required this.onItemSelected,
  });

  final void Function(ProductListEntity product, double quantity) onItemSelected;

  @override
  State<OrderItemSelectionBottomSheet> createState() =>
      _OrderItemSelectionBottomSheetState();
}

class _OrderItemSelectionBottomSheetState
    extends State<OrderItemSelectionBottomSheet> {
  ProductListEntity? _selectedProduct;
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a product'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final quantity = double.tryParse(_quantityController.text) ?? 1.0;
    widget.onItemSelected(_selectedProduct!, quantity);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Order Item',
                  style: AppStyles.body1SemiBold16(context),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Product',
              style: AppStyles.body2Medium14(context).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<MenuProductsCubit, MenuProductsState>(
              builder: (context, state) {
                List<ProductListEntity> products = [];
                if (state is MenuProductsListSuccess) {
                  products = state.products
                      .where((p) => p.isAvailable)
                      .toList();
                } else if (state is MenuProductsLoading &&
                    state.action == MenuProductsAction.fetchList) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<ProductListEntity>(
                  value: _selectedProduct,
                  onChanged: (value) {
                    setState(() {
                      _selectedProduct = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    filled: true,
                    fillColor: AppColors.inputBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.inputBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.inputBorder),
                    ),
                  ),
                  hint: Text(
                    'Select a product',
                    style: AppStyles.body2Regular14(context).copyWith(
                      color: AppColors.inputPlaceholder,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                  items: products.map((product) {
                    return DropdownMenuItem(
                      value: product,
                      child: Text(
                        product.productName,
                        style: AppStyles.body2Regular14(context).copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Quantity',
              style: AppStyles.body2Medium14(context).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _quantityController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: AppStyles.body2Regular14(context).copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. 1',
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Quantity is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Add Item',
                style: AppStyles.body1Medium16(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
