import 'package:equatable/equatable.dart';
import 'create_product_ingredient_request_entity.dart';

class CreateProductRequestEntity extends Equatable {
  const CreateProductRequestEntity({
    required this.productName,
    required this.categoryId,
    required this.sellingPrice,
    this.isAvailable = true,
    this.description,
    this.imageUrl,
    required this.ingredients,
  });

  final String productName;
  final String categoryId;
  final double sellingPrice;
  final bool isAvailable;
  final String? description;
  final String? imageUrl;
  final List<CreateProductIngredientRequestEntity> ingredients;

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'categoryId': categoryId,
      'sellingPrice': sellingPrice,
      'isAvailable': isAvailable,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
    };
  }

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
