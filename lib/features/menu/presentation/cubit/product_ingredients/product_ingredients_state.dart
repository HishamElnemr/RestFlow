import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/product_ingredient_entity.dart';

enum ProductIngredientsAction { fetchList, add, update, delete }

abstract class ProductIngredientsState extends Equatable {
  const ProductIngredientsState();

  @override
  List<Object?> get props => [];
}

class ProductIngredientsInitial extends ProductIngredientsState {
  const ProductIngredientsInitial();
}

class ProductIngredientsLoading extends ProductIngredientsState {
  const ProductIngredientsLoading(this.action);

  final ProductIngredientsAction action;

  @override
  List<Object?> get props => [action];
}

class ProductIngredientsListSuccess extends ProductIngredientsState {
  const ProductIngredientsListSuccess(this.ingredients);

  final List<ProductIngredientEntity> ingredients;

  @override
  List<Object?> get props => [ingredients];
}

class ProductIngredientsActionSuccess extends ProductIngredientsState {
  const ProductIngredientsActionSuccess(this.action);

  final ProductIngredientsAction action;

  @override
  List<Object?> get props => [action];
}

class ProductIngredientsFailure extends ProductIngredientsState {
  const ProductIngredientsFailure(this.failure, this.action);

  final AppFailure failure;
  final ProductIngredientsAction action;

  @override
  List<Object?> get props => [failure, action];
}
