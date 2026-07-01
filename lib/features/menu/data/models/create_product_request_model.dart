import '../../domain/entities/create_product_request_entity.dart';
import 'create_product_ingredient_model.dart';

class CreateProductRequestModel extends CreateProductRequestEntity {
  const CreateProductRequestModel({
    required super.productName,
    required super.categoryId,
    required super.sellingPrice,
    super.isAvailable,
    super.description,
    super.imageUrl,
    super.ingredients,
  });

  factory CreateProductRequestModel.fromEntity(
    CreateProductRequestEntity entity,
  ) {
    return CreateProductRequestModel(
      productName: entity.productName,
      categoryId: entity.categoryId,
      sellingPrice: entity.sellingPrice,
      isAvailable: entity.isAvailable,
      description: entity.description,
      imageUrl: entity.imageUrl,
      ingredients: entity.ingredients,
    );
  }

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'categoryId': categoryId,
        'sellingPrice': sellingPrice,
        'isAvailable': isAvailable,
        if (description != null) 'description': description,
        if (imageUrl != null) 'imageUrl': imageUrl,
        'ingredients': ingredients
            .map(
              (e) => CreateProductIngredientModel.fromEntity(e).toJson(),
            )
            .toList(),
      };
}
