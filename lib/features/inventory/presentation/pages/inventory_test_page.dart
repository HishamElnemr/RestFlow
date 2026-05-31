import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/create_inventory_category_request_entity.dart';
import '../../domain/entities/create_inventory_item_request_entity.dart';
import '../../domain/entities/create_stock_movement_request_entity.dart';
import '../../domain/entities/transaction_type.dart';
import '../../domain/entities/update_inventory_category_request_entity.dart';
import '../../domain/entities/update_inventory_item_request_entity.dart';
import '../cubit/inventory_categories/inventory_categories_cubit.dart';
import '../cubit/inventory_categories/inventory_categories_state.dart';
import '../cubit/inventory_items/inventory_items_cubit.dart';
import '../cubit/inventory_items/inventory_items_state.dart';
import '../cubit/low_stock/low_stock_cubit.dart';
import '../cubit/low_stock/low_stock_state.dart';
import '../cubit/stock_movements/stock_movements_cubit.dart';
import '../cubit/stock_movements/stock_movements_state.dart';

class InventoryTestPage extends StatefulWidget {
  const InventoryTestPage({super.key});

  @override
  State<InventoryTestPage> createState() => _InventoryTestPageState();
}

class _InventoryTestPageState extends State<InventoryTestPage> {
  final _itemsSearchController = TextEditingController();
  final _itemsCategoryController = TextEditingController();

  final _detailsIdController = TextEditingController();

  final _createNameController = TextEditingController();
  final _createCategoryIdController = TextEditingController();
  final _createUnitController = TextEditingController();
  final _createCurrentController = TextEditingController();
  final _createMinimumController = TextEditingController();
  final _createCostController = TextEditingController();

  final _updateIdController = TextEditingController();
  final _updateNameController = TextEditingController();
  final _updateUnitController = TextEditingController();
  final _updateMinimumController = TextEditingController();
  final _updateCostController = TextEditingController();

  final _deactivateIdController = TextEditingController();

  final _movementItemIdController = TextEditingController();
  final _movementQuantityController = TextEditingController();
  final _movementNoteController = TextEditingController();

  final _historyItemIdController = TextEditingController();

  final _createCategoryController = TextEditingController();
  final _updateCategoryIdController = TextEditingController();
  final _updateCategoryNameController = TextEditingController();

  TransactionType _movementType = TransactionType.stockIn;

  @override
  void dispose() {
    _itemsSearchController.dispose();
    _itemsCategoryController.dispose();
    _detailsIdController.dispose();
    _createNameController.dispose();
    _createCategoryIdController.dispose();
    _createUnitController.dispose();
    _createCurrentController.dispose();
    _createMinimumController.dispose();
    _createCostController.dispose();
    _updateIdController.dispose();
    _updateCategoryIdController.dispose();
    _updateNameController.dispose();
    _updateUnitController.dispose();
    _updateMinimumController.dispose();
    _updateCostController.dispose();
    _deactivateIdController.dispose();
    _movementItemIdController.dispose();
    _movementQuantityController.dispose();
    _movementNoteController.dispose();
    _historyItemIdController.dispose();
    _createCategoryController.dispose();
    _updateCategoryIdController.dispose();
    _updateCategoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Sandbox'),
        backgroundColor: colorScheme.surface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Quick Inventory Tests', style: AppStyles.title(context)),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Items List',
                child: _itemsListSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Item Details',
                child: _itemDetailsSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Create Item',
                child: _createItemSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Update Item',
                child: _updateItemSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Deactivate Item',
                child: _deactivateItemSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Stock Movements',
                child: _stockMovementSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Categories',
                child: _categoriesSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Low Stock Alerts',
                child: _lowStockSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.section(context)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _itemsListSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _itemsSearchController, label: 'Search'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _itemsCategoryController,
          label: 'Category id (optional)',
        ),
        const SizedBox(height: 12),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading =
                state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.fetchList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : () => _onFetchItems(context),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Fetch Items'),
                ),
                const SizedBox(height: 8),
                _itemsListResult(state),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _itemsListResult(InventoryItemsState state) {
    if (state is InventoryItemsFailure) {
      return _stateMessage(state.failure.message);
    }
    if (state is InventoryItemsListSuccess) {
      if (state.items.isEmpty) {
        return _stateMessage('No items found.');
      }
      return Column(
        children: state.items
            .map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.itemName, style: AppStyles.body(context)),
                          const SizedBox(height: 4),
                          Text(
                            '${item.categoryName} • ${item.unitOfMeasure}',
                            style: AppStyles.label(context),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      item.isLowStock ? 'LOW' : 'OK',
                      style: AppStyles.label(context),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _itemDetailsSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _detailsIdController, label: 'Item id'),
        const SizedBox(height: 12),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading =
                state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.fetchDetails;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _onFetchItemDetails(context),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Fetch Details'),
                ),
                const SizedBox(height: 8),
                if (state is InventoryItemDetailsSuccess)
                  _stateMessage(
                    '${state.item.itemName} • ${state.item.unitOfMeasure}\n'
                    'Qty: ${state.item.currentQuantity} | Min: ${state.item.minimumQuantity}',
                  )
                else if (state is InventoryItemsFailure)
                  _stateMessage(state.failure.message),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _createItemSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _createNameController, label: 'Item name'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createCategoryIdController,
          label: 'Category id',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createUnitController,
          label: 'Unit of measure',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createCurrentController,
          label: 'Current quantity',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createMinimumController,
          label: 'Minimum quantity',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _createCostController,
          label: 'Cost per unit',
        ),
        const SizedBox(height: 12),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading =
                state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.create;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : () => _onCreateItem(context),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Item'),
                ),
                const SizedBox(height: 8),
                if (state is InventoryItemsActionSuccess &&
                    state.action == InventoryItemsAction.create)
                  _stateMessage(
                    state.id?.isNotEmpty == true
                        ? 'Created id: ${state.id}'
                        : 'Created',
                  )
                else if (state is InventoryItemsFailure)
                  _stateMessage(state.failure.message),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _updateItemSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _updateIdController, label: 'Item id'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateCategoryIdController,
          label: 'Category id',
        ),
        const SizedBox(height: 12),
        _field(context, controller: _updateNameController, label: 'Item name'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateUnitController,
          label: 'Unit of measure',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateMinimumController,
          label: 'Minimum quantity',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateCostController,
          label: 'Cost per unit',
        ),
        const SizedBox(height: 12),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading =
                state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.update;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : () => _onUpdateItem(context),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Update Item'),
                ),
                const SizedBox(height: 8),
                if (state is InventoryItemsActionSuccess &&
                    state.action == InventoryItemsAction.update)
                  _stateMessage('Updated successfully.')
                else if (state is InventoryItemsFailure)
                  _stateMessage(state.failure.message),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _deactivateItemSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _deactivateIdController, label: 'Item id'),
        const SizedBox(height: 12),
        BlocBuilder<InventoryItemsCubit, InventoryItemsState>(
          builder: (context, state) {
            final isLoading =
                state is InventoryItemsLoading &&
                state.action == InventoryItemsAction.deactivate;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _onDeactivateItem(context),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Deactivate Item'),
                ),
                const SizedBox(height: 8),
                if (state is InventoryItemsActionSuccess &&
                    state.action == InventoryItemsAction.deactivate)
                  _stateMessage('Deactivated successfully.')
                else if (state is InventoryItemsFailure)
                  _stateMessage(state.failure.message),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _stockMovementSection(BuildContext context) {
    return Column(
      children: [
        _field(
          context,
          controller: _movementItemIdController,
          label: 'Item id',
        ),
        const SizedBox(height: 12),
        _movementTypePicker(context),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _movementQuantityController,
          label: 'Quantity',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _movementNoteController,
          label: 'Note (optional)',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _historyItemIdController,
          label: 'History item id',
        ),
        const SizedBox(height: 12),
        BlocBuilder<StockMovementsCubit, StockMovementsState>(
          builder: (context, state) {
            final isCreating =
                state is StockMovementsLoading &&
                state.action == StockMovementsAction.create;
            final isFetching =
                state is StockMovementsLoading &&
                state.action == StockMovementsAction.fetchHistory;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isCreating
                      ? null
                      : () => _onCreateMovement(context),
                  child: isCreating
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Movement'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isFetching ? null : () => _onFetchHistory(context),
                  child: isFetching
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Fetch History'),
                ),
                const SizedBox(height: 8),
                _stockMovementResult(state),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _stockMovementResult(StockMovementsState state) {
    if (state is StockMovementsFailure) {
      return _stateMessage(state.failure.message);
    }
    if (state is StockMovementsHistorySuccess) {
      if (state.movements.isEmpty) {
        return _stateMessage('No movements found.');
      }
      return Column(
        children: state.movements
            .map(
              (movement) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${movement.transactionType.name} • ${movement.quantity}',
                        style: AppStyles.body(context),
                      ),
                    ),
                    Text(
                      movement.transactionDate.toIso8601String(),
                      style: AppStyles.label(context),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );
    }
    if (state is StockMovementsActionSuccess) {
      return _stateMessage('Movement created.');
    }
    return const SizedBox.shrink();
  }

  Widget _categoriesSection(BuildContext context) {
    return Column(
      children: [
        _field(
          context,
          controller: _createCategoryController,
          label: 'New category name',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateCategoryIdController,
          label: 'Update category id',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _updateCategoryNameController,
          label: 'Update category name',
        ),
        const SizedBox(height: 12),
        BlocBuilder<InventoryCategoriesCubit, InventoryCategoriesState>(
          builder: (context, state) {
            final isLoading = state is InventoryCategoriesLoading;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _onFetchCategories(context),
                  child:
                      state is InventoryCategoriesLoading &&
                          state.action == InventoryCategoriesAction.fetchList
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Fetch Categories'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _onCreateCategory(context),
                  child:
                      state is InventoryCategoriesLoading &&
                          state.action == InventoryCategoriesAction.create
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Category'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _onUpdateCategory(context),
                  child:
                      state is InventoryCategoriesLoading &&
                          state.action == InventoryCategoriesAction.update
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Update Category'),
                ),
                const SizedBox(height: 8),
                _categoriesResult(state),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _categoriesResult(InventoryCategoriesState state) {
    if (state is InventoryCategoriesFailure) {
      return _stateMessage(state.failure.message);
    }
    if (state is InventoryCategoriesListSuccess) {
      if (state.categories.isEmpty) {
        return _stateMessage('No categories found.');
      }
      return Column(
        children: state.categories
            .map(
              (category) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.categoryName,
                        style: AppStyles.body(context),
                      ),
                    ),
                    Text(category.id, style: AppStyles.label(context)),
                  ],
                ),
              ),
            )
            .toList(),
      );
    }
    if (state is InventoryCategoriesActionSuccess) {
      return _stateMessage(
        state.message ?? 'Action completed. ${state.id ?? ''}'.trim(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _lowStockSection(BuildContext context) {
    return BlocBuilder<LowStockCubit, LowStockState>(
      builder: (context, state) {
        final isLoading = state is LowStockLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : () => _onFetchLowStock(context),
              child: isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Fetch Low Stock'),
            ),
            const SizedBox(height: 8),
            if (state is LowStockFailure)
              _stateMessage(state.failure.message)
            else if (state is LowStockSuccess)
              _lowStockResult(state)
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget _lowStockResult(LowStockSuccess state) {
    if (state.alerts.isEmpty) {
      return _stateMessage('No low stock alerts.');
    }
    return Column(
      children: state.alerts
          .map(
            (alert) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${alert.itemName} • ${alert.unitOfMeasure}',
                      style: AppStyles.body(context),
                    ),
                  ),
                  Text(
                    alert.currentQuantity.toString(),
                    style: AppStyles.label(context),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label(context)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _movementTypePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction type', style: AppStyles.label(context)),
        const SizedBox(height: 6),
        DropdownButtonFormField<TransactionType>(
          value: _movementType,
          items: TransactionType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _movementType = value);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _stateMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message, style: AppStyles.body(context)),
    );
  }

  void _onFetchItems(BuildContext context) {
    context.read<InventoryItemsCubit>().fetchInventoryItems(
      search: _itemsSearchController.text.trim().isEmpty
          ? null
          : _itemsSearchController.text.trim(),
      categoryId: _itemsCategoryController.text.trim().isEmpty
          ? null
          : _itemsCategoryController.text.trim(),
    );
  }

  void _onFetchItemDetails(BuildContext context) {
    final id = _detailsIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<InventoryItemsCubit>().fetchInventoryItemDetails(id);
  }

  void _onCreateItem(BuildContext context) {
    context.read<InventoryItemsCubit>().createInventoryItem(
      CreateInventoryItemRequestEntity(
        itemName: _createNameController.text.trim(),
        categoryId: _createCategoryIdController.text.trim(),
        unitOfMeasure: _createUnitController.text.trim(),
        currentQuantity: _parseDouble(_createCurrentController.text),
        minimumQuantity: _parseDouble(_createMinimumController.text),
        costPerUnit: _parseDouble(_createCostController.text),
      ),
    );
  }

  void _onUpdateItem(BuildContext context) {
    final id = _updateIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<InventoryItemsCubit>().updateInventoryItem(
      id,
      UpdateInventoryItemRequestEntity(
        categoryId: _updateCategoryIdController.text.trim(),
        itemName: _updateNameController.text.trim(),
        unitOfMeasure: _updateUnitController.text.trim(),
        minimumQuantity: _parseDouble(_updateMinimumController.text),
        costPerUnit: _parseDouble(_updateCostController.text),
      ),
    );
  }

  void _onDeactivateItem(BuildContext context) {
    final id = _deactivateIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<InventoryItemsCubit>().deactivateInventoryItem(id);
  }

  void _onCreateMovement(BuildContext context) {
    final itemId = _movementItemIdController.text.trim();
    if (itemId.isEmpty) {
      return;
    }
    context.read<StockMovementsCubit>().createMovement(
      itemId,
      CreateStockMovementRequestEntity(
        transactionType: _movementType,
        quantity: _parseDouble(_movementQuantityController.text),
        note: _movementNoteController.text.trim().isEmpty
            ? null
            : _movementNoteController.text.trim(),
      ),
    );
  }

  void _onFetchHistory(BuildContext context) {
    final itemId = _historyItemIdController.text.trim();
    if (itemId.isEmpty) {
      return;
    }
    context.read<StockMovementsCubit>().fetchHistory(itemId);
  }

  void _onFetchCategories(BuildContext context) {
    context.read<InventoryCategoriesCubit>().fetchCategories();
  }

  void _onCreateCategory(BuildContext context) {
    context.read<InventoryCategoriesCubit>().createCategory(
      CreateInventoryCategoryRequestEntity(
        categoryName: _createCategoryController.text.trim(),
      ),
    );
  }

  void _onUpdateCategory(BuildContext context) {
    final id = _updateCategoryIdController.text.trim();
    if (id.isEmpty) {
      return;
    }
    context.read<InventoryCategoriesCubit>().updateCategory(
      id,
      UpdateInventoryCategoryRequestEntity(
        categoryName: _updateCategoryNameController.text.trim(),
      ),
    );
  }

  void _onFetchLowStock(BuildContext context) {
    context.read<LowStockCubit>().fetchLowStockAlerts();
  }

  double _parseDouble(String value) {
    return double.tryParse(value.trim()) ?? 0.0;
  }
}
