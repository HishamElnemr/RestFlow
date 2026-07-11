import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/inventory_category_list_entity.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_categories/inventory_categories_state.dart';

typedef InventoryFilterApplyCallback = void Function(
  String? categoryId,
  double? minQuantity,
  double? maxQuantity,
  double? minCost,
  double? maxCost,
);

class InventoryFilterBottomSheet extends StatefulWidget {
  const InventoryFilterBottomSheet({
    super.key,
    required this.selectedCategoryId,
    required this.minQuantity,
    required this.maxQuantity,
    required this.minCost,
    required this.maxCost,
    required this.onApply,
  });

  final String? selectedCategoryId;
  final double? minQuantity;
  final double? maxQuantity;
  final double? minCost;
  final double? maxCost;
  final InventoryFilterApplyCallback onApply;

  @override
  State<InventoryFilterBottomSheet> createState() =>
      _InventoryFilterBottomSheetState();
}

class _InventoryFilterBottomSheetState
    extends State<InventoryFilterBottomSheet> {
  String? _selectedCategoryId;
  final TextEditingController _minQController = TextEditingController();
  final TextEditingController _maxQController = TextEditingController();
  final TextEditingController _minCostController = TextEditingController();
  final TextEditingController _maxCostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.selectedCategoryId;
    if (widget.minQuantity != null) _minQController.text = widget.minQuantity.toString();
    if (widget.maxQuantity != null) _maxQController.text = widget.maxQuantity.toString();
    if (widget.minCost != null) _minCostController.text = widget.minCost.toString();
    if (widget.maxCost != null) _maxCostController.text = widget.maxCost.toString();

    context.read<InventoryCategoriesCubit>().fetchCategories();
  }

  @override
  void dispose() {
    _minQController.dispose();
    _maxQController.dispose();
    _minCostController.dispose();
    _maxCostController.dispose();
    super.dispose();
  }

  void _apply() {
    final minQ = double.tryParse(_minQController.text);
    final maxQ = double.tryParse(_maxQController.text);
    final minCost = double.tryParse(_minCostController.text);
    final maxCost = double.tryParse(_maxCostController.text);
    widget.onApply(_selectedCategoryId, minQ, maxQ, minCost, maxCost);
  }

  void _clearAll() {
    setState(() {
      _selectedCategoryId = null;
      _minQController.clear();
      _maxQController.clear();
      _minCostController.clear();
      _maxCostController.clear();
    });
    widget.onApply(null, null, null, null, null);
  }

  bool get _hasAny =>
      _selectedCategoryId != null ||
      _minQController.text.isNotEmpty ||
      _maxQController.text.isNotEmpty ||
      _minCostController.text.isNotEmpty ||
      _maxCostController.text.isNotEmpty;

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyles.body2Medium14(context).copyWith(color: AppColors.mutedGray),
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
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
            
            // Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Category',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<InventoryCategoriesCubit, InventoryCategoriesState>(
                builder: (context, state) {
                  final isLoading = state is InventoryCategoriesLoading;
                  final categories = state is InventoryCategoriesListSuccess
                      ? state.categories
                      : [
                          InventoryCategoryListEntity(
                            id: 'dummy',
                            categoryName: 'Loading...',
                            createdAt: DateTime.now(),
                          ),
                          InventoryCategoryListEntity(
                            id: 'dummy2',
                            categoryName: 'Loading...',
                            createdAt: DateTime.now(),
                          )
                        ];

                  if (state is InventoryCategoriesFailure) {
                    return Text(
                      state.failure.message,
                      style: const TextStyle(color: AppColors.error),
                    );
                  }

                  return Skeletonizer(
                    enabled: isLoading,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          selected: _selectedCategoryId == null,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedCategoryId = null);
                            }
                          },
                          selectedColor: AppColors.primary,
                          checkmarkColor: AppColors.white,
                          labelStyle: AppStyles.body2Medium14(context).copyWith(
                            color: _selectedCategoryId == null
                                ? AppColors.white
                                : AppColors.darkNavy,
                          ),
                          backgroundColor: AppColors.backgroundLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        ...categories.map((category) {
                          final isSelected = _selectedCategoryId == category.id;
                          return ChoiceChip(
                            label: Text(category.categoryName),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategoryId =
                                    selected ? category.id : null;
                              });
                            },
                            selectedColor: AppColors.primary,
                            checkmarkColor: AppColors.white,
                            labelStyle:
                                AppStyles.body2Medium14(context).copyWith(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.darkNavy,
                            ),
                            backgroundColor: AppColors.backgroundLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),

            // Quantity Range
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Quantity Range',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _buildTextField(_minQController, 'Min Qty')),
                  const SizedBox(width: 16),
                  Text('-', style: AppStyles.body2Medium14(context).copyWith(color: AppColors.darkNavy, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_maxQController, 'Max Qty')),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),

            // Cost Range
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Cost Range',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _buildTextField(_minCostController, 'Min Cost')),
                  const SizedBox(width: 16),
                  Text('-', style: AppStyles.body2Medium14(context).copyWith(color: AppColors.darkNavy, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_maxCostController, 'Max Cost')),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _apply();
                    Navigator.pop(context);
                  },
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
      ),
    );
  }
}
