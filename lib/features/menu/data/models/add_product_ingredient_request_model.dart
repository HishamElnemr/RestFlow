import '../../domain/entities/add_product_ingredient_request_entity.dart';

class AddProductIngredientRequestModel extends AddProductIngredientRequestEntity {
  const AddProductIngredientRequestModel({
    required super.productId,
    required super.inventoryItemId,
    required super.quantityRequired,
  });

  factory AddProductIngredientRequestModel.fromEntity(
    AddProductIngredientRequestEntity entity,
  ) {
    return AddProductIngredientRequestModel(
      productId: entity.productId,
      inventoryItemId: entity.inventoryItemId,
      quantityRequired: entity.quantityRequired,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'inventoryItemId': inventoryItemId,
        'quantityRequired': quantityRequired,
      };
}
