import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/inventory_item_details_entity.dart';
import '../../../domain/entities/inventory_item_list_entity.dart';

enum InventoryItemsAction {
  fetchList,
  fetchDetails,
  create,
  update,
  deactivate,
}

abstract class InventoryItemsState extends Equatable {
  const InventoryItemsState();

  @override
  List<Object?> get props => [];
}

class InventoryItemsInitial extends InventoryItemsState {
  const InventoryItemsInitial();
}

class InventoryItemsLoading extends InventoryItemsState {
  const InventoryItemsLoading(this.action);

  final InventoryItemsAction action;

  @override
  List<Object?> get props => [action];
}

class InventoryItemsListSuccess extends InventoryItemsState {
  const InventoryItemsListSuccess(this.items);

  final List<InventoryItemListEntity> items;

  @override
  List<Object?> get props => [items];
}

class InventoryItemDetailsSuccess extends InventoryItemsState {
  const InventoryItemDetailsSuccess(this.item);

  final InventoryItemDetailsEntity item;

  @override
  List<Object?> get props => [item];
}

class InventoryItemsActionSuccess extends InventoryItemsState {
  const InventoryItemsActionSuccess(this.action, {this.id});

  final InventoryItemsAction action;
  final String? id;

  @override
  List<Object?> get props => [action, id];
}

class InventoryItemsFailure extends InventoryItemsState {
  const InventoryItemsFailure(this.failure, this.action);

  final AppFailure failure;
  final InventoryItemsAction action;

  @override
  List<Object?> get props => [failure, action];
}
