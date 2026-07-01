import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/product_details_entity.dart';
import '../../../domain/entities/product_list_entity.dart';

enum MenuProductsAction {
  fetchList,
  fetchDetails,
  create,
  update,
  changeAvailability,
}

abstract class MenuProductsState extends Equatable {
  const MenuProductsState();

  @override
  List<Object?> get props => [];
}

class MenuProductsInitial extends MenuProductsState {
  const MenuProductsInitial();
}

class MenuProductsLoading extends MenuProductsState {
  const MenuProductsLoading(this.action);

  final MenuProductsAction action;

  @override
  List<Object?> get props => [action];
}

class MenuProductsListSuccess extends MenuProductsState {
  const MenuProductsListSuccess(this.products);

  final List<ProductListEntity> products;

  @override
  List<Object?> get props => [products];
}

class MenuProductDetailsSuccess extends MenuProductsState {
  const MenuProductDetailsSuccess(this.product);

  final ProductDetailsEntity product;

  @override
  List<Object?> get props => [product];
}

class MenuProductsActionSuccess extends MenuProductsState {
  const MenuProductsActionSuccess(this.action, {this.productId});

  final MenuProductsAction action;
  final String? productId;

  @override
  List<Object?> get props => [action, productId];
}

class MenuProductsFailure extends MenuProductsState {
  const MenuProductsFailure(this.failure, this.action);

  final AppFailure failure;
  final MenuProductsAction action;

  @override
  List<Object?> get props => [failure, action];
}
