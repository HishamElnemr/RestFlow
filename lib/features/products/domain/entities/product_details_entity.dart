import 'package:equatable/equatable.dart';
import 'product_ingredient_entity.dart';

class ProductDetailsEntity extends Equatable {
  const ProductDetailsEntity({
    required this.id,
    required this.productName,
    this.description,
    required this.sellingPrice,
    this.imageUrl,
    required this.isAvailable,
    required this.categoryName,
    required this.ingredients,
  });

  final String id;
  final String productName;
  final String? description;
  final double sellingPrice;
  final String? imageUrl;
  final bool isAvailable;
  final String categoryName;
  final List<ProductIngredientEntity> ingredients;

  @override
  List<Object?> get props => [
        id,
        productName,
        description,
        sellingPrice,
        imageUrl,
        isAvailable,
        categoryName,
        ingredients,
      ];
}
