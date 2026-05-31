import '../../domain/entities/inventory_category_entity.dart';

class InventoryCategoryModel extends InventoryCategoryEntity {
  const InventoryCategoryModel({
    required super.id,
    required super.categoryName,
  });

  factory InventoryCategoryModel.fromEntity(InventoryCategoryEntity entity) {
    return InventoryCategoryModel(
      id: entity.id,
      categoryName: entity.categoryName,
    );
  }

  InventoryCategoryEntity toEntity() {
    return InventoryCategoryEntity(id: id, categoryName: categoryName);
  }

  factory InventoryCategoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryCategoryModel(
      id: (json['id'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'categoryName': categoryName};
}
