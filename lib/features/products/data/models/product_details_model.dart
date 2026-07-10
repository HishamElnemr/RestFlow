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
    var ingredientsList = json['ingredients'] as List?;
    return ProductDetailsModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      description: json['description'] as String?,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isAvailable: json['isAvailable'] as bool,
      categoryName: json['categoryName'] as String,
      ingredients: ingredientsList != null
          ? ingredientsList
              .map((i) => ProductIngredientModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
