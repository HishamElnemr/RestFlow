import 'package:equatable/equatable.dart';
import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/features/menu/domain/entities/product_details_entity.dart';
import 'package:rest_flow/features/menu/domain/entities/product_list_entity.dart';

enum ProductsAction {
  fetchAll,
  fetchDetails,
  create,
  update,
  changeAvailability
}

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  final ProductsAction action;

  const ProductsLoading(this.action);

  @override
  List<Object?> get props => [action];
}

class ProductsListLoaded extends ProductsState {
  final List<ProductListEntity> products;

  const ProductsListLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductDetailsLoaded extends ProductsState {
  final ProductDetailsEntity product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductActionSuccess extends ProductsState {
  final ProductsAction action;
  final String? newProductId;

  const ProductActionSuccess(this.action, {this.newProductId});

  @override
  List<Object?> get props => [action, newProductId];
}

class ProductsFailure extends ProductsState {
  final AppFailure failure;
  final ProductsAction action;

  const ProductsFailure(this.failure, this.action);

  @override
  List<Object?> get props => [failure, action];
}
