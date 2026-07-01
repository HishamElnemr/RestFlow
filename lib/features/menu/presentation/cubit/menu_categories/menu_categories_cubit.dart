import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/create_menu_category_request_entity.dart';
import '../../../domain/repositories/menu_repository.dart';
import 'menu_categories_state.dart';

class MenuCategoriesCubit extends Cubit<MenuCategoriesState> {
  MenuCategoriesCubit(this._repository) : super(const MenuCategoriesInitial());

  final MenuRepository _repository;

  Future<void> fetchCategories() async {
    emit(const MenuCategoriesLoading(MenuCategoriesAction.fetchList));
    final result = await _repository.getMenuCategories();
    result.fold(
      (failure) => emit(
        MenuCategoriesFailure(failure, MenuCategoriesAction.fetchList),
      ),
      (categories) => emit(MenuCategoriesListSuccess(categories)),
    );
  }

  Future<void> createCategory(CreateMenuCategoryRequestEntity request) async {
    emit(const MenuCategoriesLoading(MenuCategoriesAction.create));
    final result = await _repository.createMenuCategory(request);
    result.fold(
      (failure) =>
          emit(MenuCategoriesFailure(failure, MenuCategoriesAction.create)),
      (id) => emit(MenuCategoriesActionSuccess(MenuCategoriesAction.create, id: id)),
    );
  }

  Future<void> updateCategory(
    String id,
    CreateMenuCategoryRequestEntity request,
  ) async {
    emit(const MenuCategoriesLoading(MenuCategoriesAction.update));
    final result = await _repository.updateMenuCategory(id, request);
    result.fold(
      (failure) =>
          emit(MenuCategoriesFailure(failure, MenuCategoriesAction.update)),
      (_) => emit(const MenuCategoriesActionSuccess(MenuCategoriesAction.update)),
    );
  }

  void reset() => emit(const MenuCategoriesInitial());
}
