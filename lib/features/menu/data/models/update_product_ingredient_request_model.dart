import '../../domain/entities/update_product_ingredient_request_entity.dart';

class UpdateProductIngredientRequestModel
    extends UpdateProductIngredientRequestEntity {
  const UpdateProductIngredientRequestModel({
    super.inventoryItemId,
    super.quantityRequired,
  });

  factory UpdateProductIngredientRequestModel.fromEntity(
    UpdateProductIngredientRequestEntity entity,
  ) {
    return UpdateProductIngredientRequestModel(
      inventoryItemId: entity.inventoryItemId,
      quantityRequired: entity.quantityRequired,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (inventoryItemId != null) map['inventoryItemId'] = inventoryItemId;
    if (quantityRequired != null) map['quantityRequired'] = quantityRequired;
    return map;
  }
}
