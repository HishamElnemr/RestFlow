import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/inventory_category_list_entity.dart';
import 'inventory_text_field.dart';

class InventoryFormFields extends StatelessWidget {
  const InventoryFormFields({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.unitController,
    required this.minQuantityController,
    required this.costController,
    this.currentQuantityController,
    required this.selectedCategoryId,
    required this.categories,
    required this.onCategoryChanged,
    required this.isEditMode,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController unitController;
  final TextEditingController minQuantityController;
  final TextEditingController costController;
  final TextEditingController? currentQuantityController;
  final String? selectedCategoryId;
  final List<InventoryCategoryListEntity> categories;
  final ValueChanged<String?> onCategoryChanged;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InventoryTextField(
            label: 'Item Name',
            controller: nameController,
            hintText: 'e.g. Tomato Paste',
            onChanged: (_) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Item name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildCategoryDropdown(context),
          const SizedBox(height: 20),
          InventoryTextField(
            label: 'Unit of Measure',
            controller: unitController,
            hintText: 'e.g. kg, liters, boxes',
            onChanged: (_) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Unit of measure is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          if (!isEditMode && currentQuantityController != null) ...[
            InventoryTextField(
              label: 'Current Quantity',
              controller: currentQuantityController!,
              hintText: 'e.g. 50',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) {},
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Current quantity is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
          InventoryTextField(
            label: 'Minimum Quantity',
            controller: minQuantityController,
            hintText: 'e.g. 10',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Minimum quantity is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          InventoryTextField(
            label: 'Cost Per Unit',
            controller: costController,
            hintText: 'e.g. 15.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Cost per unit is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCategoryId,
          onChanged: onCategoryChanged,
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
            'Select a category',
            style: AppStyles.body2Regular14(context).copyWith(
              color: AppColors.inputPlaceholder,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category';
            }
            return null;
          },
          items: categories.map((category) {
            return DropdownMenuItem(
              value: category.id,
              child: Text(
                category.categoryName,
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
}
