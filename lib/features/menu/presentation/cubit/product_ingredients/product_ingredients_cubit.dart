import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/add_product_ingredient_request_entity.dart';
import '../../../domain/entities/update_product_ingredient_request_entity.dart';
import '../../../domain/repositories/menu_repository.dart';
import 'product_ingredients_state.dart';

class ProductIngredientsCubit extends Cubit<ProductIngredientsState> {
  ProductIngredientsCubit(this._repository)
      : super(const ProductIngredientsInitial());

  final MenuRepository _repository;

  Future<void> fetchIngredients(String productId) async {
    emit(const ProductIngredientsLoading(ProductIngredientsAction.fetchList));
    final result = await _repository.getProductIngredients(productId);
    result.fold(
      (failure) => emit(
        ProductIngredientsFailure(failure, ProductIngredientsAction.fetchList),
      ),
      (ingredients) => emit(ProductIngredientsListSuccess(ingredients)),
    );
  }

  Future<void> addIngredient(AddProductIngredientRequestEntity request) async {
    emit(const ProductIngredientsLoading(ProductIngredientsAction.add));
    final result = await _repository.addProductIngredient(request);
    result.fold(
      (failure) => emit(
        ProductIngredientsFailure(failure, ProductIngredientsAction.add),
      ),
      (_) => emit(
        const ProductIngredientsActionSuccess(ProductIngredientsAction.add),
      ),
    );
  }

  Future<void> updateIngredient(
    String productId,
    String ingredientId,
    UpdateProductIngredientRequestEntity request,
  ) async {
    emit(const ProductIngredientsLoading(ProductIngredientsAction.update));
    final result = await _repository.updateProductIngredient(
      productId,
      ingredientId,
      request,
    );
    result.fold(
      (failure) => emit(
        ProductIngredientsFailure(failure, ProductIngredientsAction.update),
      ),
      (_) => emit(
        const ProductIngredientsActionSuccess(ProductIngredientsAction.update),
      ),
    );
  }

  Future<void> deleteIngredient(String id) async {
    emit(const ProductIngredientsLoading(ProductIngredientsAction.delete));
    final result = await _repository.deleteProductIngredient(id);
    result.fold(
      (failure) => emit(
        ProductIngredientsFailure(failure, ProductIngredientsAction.delete),
      ),
      (_) => emit(
        const ProductIngredientsActionSuccess(ProductIngredientsAction.delete),
      ),
    );
  }

  void reset() => emit(const ProductIngredientsInitial());
}
