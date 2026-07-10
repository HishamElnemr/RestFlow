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
      id: json['id'] as String,
      productName: json['productName'] as String,
      categoryName: json['categoryName'] as String,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
