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
