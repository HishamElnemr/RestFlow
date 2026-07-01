import '../../domain/entities/product_details_entity.dart';
import 'product_ingredient_model.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.id,
    required super.productName,
    super.description,
    required super.sellingPrice,
    super.imageUrl,
    required super.isAvailable,
    required super.categoryName,
    required super.ingredients,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final ingredientsList = (json['ingredients'] as List<dynamic>? ?? [])
        .map((e) => ProductIngredientModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProductDetailsModel(
      id: (json['id'] ?? '').toString(),
      productName: (json['productName'] ?? '').toString(),
      description: json['description'] as String?,
      sellingPrice: (json['sellingPrice'] as num? ?? 0).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isAvailable: (json['isAvailable'] as bool? ?? true),
      categoryName: (json['categoryName'] ?? '').toString(),
      ingredients: ingredientsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'description': description,
        'sellingPrice': sellingPrice,
        'imageUrl': imageUrl,
        'isAvailable': isAvailable,
        'categoryName': categoryName,
        'ingredients': (ingredients as List<ProductIngredientModel>)
            .map((e) => e.toJson())
            .toList(),
      };
}
