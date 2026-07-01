import 'package:equatable/equatable.dart';

import 'create_product_ingredient_entity.dart';

class CreateProductRequestEntity extends Equatable {
  const CreateProductRequestEntity({
    required this.productName,
    required this.categoryId,
    required this.sellingPrice,
    this.isAvailable = true,
    this.description,
    this.imageUrl,
    this.ingredients = const [],
  });

  final String productName;
  final String categoryId;
  final double sellingPrice;
  final bool isAvailable;
  final String? description;
  final String? imageUrl;
  final List<CreateProductIngredientEntity> ingredients;

  @override
  List<Object?> get props => [
        productName,
        categoryId,
        sellingPrice,
        isAvailable,
        description,
        imageUrl,
        ingredients,
      ];
}
