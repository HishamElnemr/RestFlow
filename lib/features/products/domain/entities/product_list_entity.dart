import 'package:equatable/equatable.dart';

class ProductListEntity extends Equatable {
  const ProductListEntity({
    required this.id,
    required this.productName,
    required this.categoryName,
    required this.sellingPrice,
    required this.isAvailable,
  });

  final String id;
  final String productName;
  final String categoryName;
  final double sellingPrice;
  final bool isAvailable;

  @override
  List<Object?> get props => [
        id,
        productName,
        categoryName,
        sellingPrice,
        isAvailable,
      ];
}
