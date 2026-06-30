import '../../domain/entities/menu_performance_entity.dart';

class MenuPerformanceModel extends MenuPerformanceEntity {
  const MenuPerformanceModel({
    required super.productId,
    required super.productName,
    required super.quantitySold,
  });

  factory MenuPerformanceModel.fromJson(Map<String, dynamic> json) {
    return MenuPerformanceModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantitySold: (json['quantitySold'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantitySold': quantitySold,
    };
  }

  MenuPerformanceEntity toEntity() {
    return MenuPerformanceEntity(
      productId: productId,
      productName: productName,
      quantitySold: quantitySold,
    );
  }
}
