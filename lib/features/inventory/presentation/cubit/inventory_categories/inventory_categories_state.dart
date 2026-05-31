import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/inventory_category_list_entity.dart';

enum InventoryCategoriesAction { fetchList, create, update }

abstract class InventoryCategoriesState extends Equatable {
  const InventoryCategoriesState();

  @override
  List<Object?> get props => [];
}

class InventoryCategoriesInitial extends InventoryCategoriesState {
  const InventoryCategoriesInitial();
}

class InventoryCategoriesLoading extends InventoryCategoriesState {
  const InventoryCategoriesLoading(this.action);

  final InventoryCategoriesAction action;

  @override
  List<Object?> get props => [action];
}

class InventoryCategoriesListSuccess extends InventoryCategoriesState {
  const InventoryCategoriesListSuccess(this.categories);

  final List<InventoryCategoryListEntity> categories;

  @override
  List<Object?> get props => [categories];
}

class InventoryCategoriesActionSuccess extends InventoryCategoriesState {
  const InventoryCategoriesActionSuccess(this.action, {this.id, this.message});

  final InventoryCategoriesAction action;
  final String? id;
  final String? message;

  @override
  List<Object?> get props => [action, id, message];
}

class InventoryCategoriesFailure extends InventoryCategoriesState {
  const InventoryCategoriesFailure(this.failure, this.action);

  final AppFailure failure;
  final InventoryCategoriesAction action;

  @override
  List<Object?> get props => [failure, action];
}
