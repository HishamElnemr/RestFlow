import '../../domain/entities/create_product_ingredient_entity.dart';

class CreateProductIngredientModel extends CreateProductIngredientEntity {
  const CreateProductIngredientModel({
    required super.inventoryItemId,
    required super.quantityRequired,
  });

  factory CreateProductIngredientModel.fromEntity(
    CreateProductIngredientEntity entity,
  ) {
    return CreateProductIngredientModel(
      inventoryItemId: entity.inventoryItemId,
      quantityRequired: entity.quantityRequired,
    );
  }

  Map<String, dynamic> toJson() => {
        'inventoryItemId': inventoryItemId,
        'quantityRequired': quantityRequired,
      };
}
