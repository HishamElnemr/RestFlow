/// Simple response returned by createProduct endpoint.
/// Contains the newly created product's ID.
class ProductCreationResponseModel {
  const ProductCreationResponseModel({required this.productId});

  final String productId;

  factory ProductCreationResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductCreationResponseModel(
      productId: (json['productId'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'productId': productId};
}
