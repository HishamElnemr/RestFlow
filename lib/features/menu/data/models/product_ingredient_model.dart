import '../../domain/entities/product_ingredient_entity.dart';

class ProductIngredientModel extends ProductIngredientEntity {
  const ProductIngredientModel({
    required super.inventoryItemName,
    required super.quantityRequired,
  });

  factory ProductIngredientModel.fromJson(Map<String, dynamic> json) {
    return ProductIngredientModel(
      inventoryItemName: (json['inventoryItemName'] ?? '').toString(),
      quantityRequired: (json['quantityRequired'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'inventoryItemName': inventoryItemName,
        'quantityRequired': quantityRequired,
      };
}
