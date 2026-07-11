import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/inventory_category_list_entity.dart';
import '../../domain/entities/update_inventory_item_request_entity.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_categories/inventory_categories_state.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../cubit/inventory_items/inventory_items_state.dart';
import 'inventory_form_fields.dart';
import 'inventory_save_button.dart';

class EditInventoryItemPageBody extends StatefulWidget {
  const EditInventoryItemPageBody({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  State<EditInventoryItemPageBody> createState() =>
      _EditInventoryItemPageBodyState();
}

class _EditInventoryItemPageBodyState extends State<EditInventoryItemPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _unitController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _costController = TextEditingController();
  String? _selectedCategoryId;

  List<InventoryCategoryListEntity> _categories = [];
  bool _isDataLoaded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _unitController.dispose();
    _minQuantityController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) return;

    final request = UpdateInventoryItemRequestEntity(
      categoryId: _selectedCategoryId!,
      itemName: _nameController.text.trim(),
      unitOfMeasure: _unitController.text.trim(),
      minimumQuantity: double.parse(_minQuantityController.text.trim()),
      costPerUnit: double.parse(_costController.text.trim()),
    );

    context
        .read<InventoryItemsCubit>()
        .updateInventoryItem(widget.itemId, request);
  }

  void _populateForm(state) {
    if (_isDataLoaded) return;
    final item = state.item;
    _nameController.text = item.itemName;
    _unitController.text = item.unitOfMeasure;
    _minQuantityController.text = item.minimumQuantity.toString();
    _costController.text = item.costPerUnit.toString();
    
    String? matchedId = item.categoryId.isNotEmpty ? item.categoryId : null;
    
    if (matchedId == null && _categories.isNotEmpty) {
      try {
        final c = _categories.firstWhere((cat) => cat.categoryName == item.categoryName);
        matchedId = c.id;
      } catch (_) {}
    }
    
    _selectedCategoryId = matchedId;
    _isDataLoaded = true;
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
                if (_isDataLoaded && _selectedCategoryId == null) {
                  final itemState = context.read<InventoryItemsCubit>().state;
                  if (itemState is InventoryItemDetailsSuccess) {
                    try {
                      final c = _categories.firstWhere(
                          (cat) => cat.categoryName == itemState.item.categoryName);
                      _selectedCategoryId = c.id;
                    } catch (_) {}
                  }
                } else if (_isDataLoaded && _selectedCategoryId != null) {
                  // Ensure the selected ID actually exists in the newly loaded categories
                  final exists = _categories.any((c) => c.id == _selectedCategoryId);
                  if (!exists) {
                    _selectedCategoryId = null;
                  }
                }
              });
            }
          },
        ),
        BlocListener<InventoryItemsCubit, InventoryItemsState>(
          listener: (context, state) {
            if (state is InventoryItemDetailsSuccess) {
              setState(() {
                _populateForm(state);
              });
            } else if (state is InventoryItemsFailure &&
                state.action == InventoryItemsAction.update) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: AppColors.error,
                ),
              );
            } else if (state is InventoryItemsActionSuccess &&
                state.action == InventoryItemsAction.update) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inventory item updated successfully'),
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
            title: 'Edit Inventory Item',
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
              buildWhen: (previous, current) {
                return current is InventoryItemsLoading ||
                    current is InventoryItemDetailsSuccess ||
                    current is InventoryItemsFailure;
              },
              builder: (context, state) {
                final isFetching = state is InventoryItemsLoading &&
                    state.action == InventoryItemsAction.fetchDetails;
                final isError = state is InventoryItemsFailure &&
                    state.action == InventoryItemsAction.fetchDetails;

                if (isError) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Text(
                        state.failure.message,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  );
                }

                return Skeletonizer(
                  enabled: isFetching && !_isDataLoaded,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InventoryFormFields(
                          formKey: _formKey,
                          nameController: _nameController,
                          unitController: _unitController,
                          minQuantityController: _minQuantityController,
                          costController: _costController,
                          selectedCategoryId: _selectedCategoryId,
                          categories: _categories.isNotEmpty
                              ? _categories
                              : [
                                  InventoryCategoryListEntity(
                                    id: _selectedCategoryId ?? 'dummy',
                                    categoryName: 'Loading...',
                                    createdAt: DateTime.now(),
                                  )
                                ],
                          onCategoryChanged: (value) {
                            setState(() {
                              _selectedCategoryId = value;
                            });
                          },
                          isEditMode: true,
                        ),
                        const SizedBox(height: 32),
                        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
                          builder: (context, actionState) {
                            final isUpdating =
                                actionState is InventoryItemsLoading &&
                                    actionState.action ==
                                        InventoryItemsAction.update;
                            return InventorySaveButton(
                              label: 'Save Changes',
                              isLoading: isUpdating,
                              onPressed: _onSave,
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
