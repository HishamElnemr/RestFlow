import '../../domain/entities/product_ingredient_entity.dart';

class ProductIngredientModel extends ProductIngredientEntity {
  const ProductIngredientModel({
    required super.inventoryItemName,
    required super.quantityRequired,
  });

  factory ProductIngredientModel.fromJson(Map<String, dynamic> json) {
    return ProductIngredientModel(
      inventoryItemName: json['inventoryItemName'] as String,
      quantityRequired: (json['quantityRequired'] as num).toDouble(),
    );
  }
}
