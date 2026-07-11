import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/create_inventory_item_request_entity.dart';
import '../../domain/entities/inventory_category_list_entity.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_categories/inventory_categories_state.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../cubit/inventory_items/inventory_items_state.dart';
import 'inventory_form_fields.dart';
import 'inventory_save_button.dart';

class AddInventoryItemPageBody extends StatefulWidget {
  const AddInventoryItemPageBody({super.key});

  @override
  State<AddInventoryItemPageBody> createState() =>
      _AddInventoryItemPageBodyState();
}

class _AddInventoryItemPageBodyState extends State<AddInventoryItemPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _unitController = TextEditingController();
  final _currentQuantityController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _costController = TextEditingController();
  String? _selectedCategoryId;

  List<InventoryCategoryListEntity> _categories = [];

  @override
  void dispose() {
    _nameController.dispose();
    _unitController.dispose();
    _currentQuantityController.dispose();
    _minQuantityController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) return;

    final request = CreateInventoryItemRequestEntity(
      itemName: _nameController.text.trim(),
      categoryId: _selectedCategoryId!,
      unitOfMeasure: _unitController.text.trim(),
      currentQuantity: double.parse(_currentQuantityController.text.trim()),
      minimumQuantity: double.parse(_minQuantityController.text.trim()),
      costPerUnit: double.parse(_costController.text.trim()),
    );

    context.read<InventoryItemsCubit>().createInventoryItem(request);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryCategoriesCubit, InventoryCategoriesState>(
          listener: (context, state) {
            if (state is InventoryCategoriesListSuccess) {
              setState(() {
                _categories = state.categories;
              });
            } else if (state is InventoryCategoriesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Failed to load categories: ${state.failure.message}'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        ),
        BlocListener<InventoryItemsCubit, InventoryItemsState>(
          listener: (context, state) {
            if (state is InventoryItemsFailure &&
                state.action == InventoryItemsAction.create) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: AppColors.error,
                ),
              );
            } else if (state is InventoryItemsActionSuccess &&
                state.action == InventoryItemsAction.create) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inventory item added successfully'),
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
            title: 'Add Inventory Item',
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InventoryFormFields(
                    formKey: _formKey,
                    nameController: _nameController,
                    unitController: _unitController,
                    currentQuantityController: _currentQuantityController,
                    minQuantityController: _minQuantityController,
                    costController: _costController,
                    selectedCategoryId: _selectedCategoryId,
                    categories: _categories,
                    onCategoryChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value;
                      });
                    },
                    isEditMode: false,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
                    builder: (context, state) {
                      final isLoading = state is InventoryItemsLoading &&
                          state.action == InventoryItemsAction.create;
                      return InventorySaveButton(
                        label: 'Save Item',
                        isLoading: isLoading,
                        onPressed: _onSave,
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
}
