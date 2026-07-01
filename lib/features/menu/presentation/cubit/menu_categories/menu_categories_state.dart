import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/menu_category_list_entity.dart';

enum MenuCategoriesAction { fetchList, create, update }

abstract class MenuCategoriesState extends Equatable {
  const MenuCategoriesState();

  @override
  List<Object?> get props => [];
}

class MenuCategoriesInitial extends MenuCategoriesState {
  const MenuCategoriesInitial();
}

class MenuCategoriesLoading extends MenuCategoriesState {
  const MenuCategoriesLoading(this.action);

  final MenuCategoriesAction action;

  @override
  List<Object?> get props => [action];
}

class MenuCategoriesListSuccess extends MenuCategoriesState {
  const MenuCategoriesListSuccess(this.categories);

  final List<MenuCategoryListEntity> categories;

  @override
  List<Object?> get props => [categories];
}

class MenuCategoriesActionSuccess extends MenuCategoriesState {
  const MenuCategoriesActionSuccess(this.action, {this.id});

  final MenuCategoriesAction action;
  final String? id;

  @override
  List<Object?> get props => [action, id];
}

class MenuCategoriesFailure extends MenuCategoriesState {
  const MenuCategoriesFailure(this.failure, this.action);

  final AppFailure failure;
  final MenuCategoriesAction action;

  @override
  List<Object?> get props => [failure, action];
}
