import '../../domain/entities/product_list_entity.dart';

class ProductListModel extends ProductListEntity {
  const ProductListModel({
    required super.id,
    required super.productName,
    required super.categoryName,
    required super.sellingPrice,
    required super.isAvailable,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: (json['id'] ?? '').toString(),
      productName: (json['productName'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      sellingPrice: (json['sellingPrice'] as num? ?? 0).toDouble(),
      isAvailable: (json['isAvailable'] as bool? ?? true),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'categoryName': categoryName,
        'sellingPrice': sellingPrice,
        'isAvailable': isAvailable,
      };
}
