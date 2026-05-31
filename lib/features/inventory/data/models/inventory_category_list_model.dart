import '../../domain/entities/inventory_category_list_entity.dart';
import 'inventory_parsers.dart';

class InventoryCategoryListModel extends InventoryCategoryListEntity {
  const InventoryCategoryListModel({
    required super.id,
    required super.categoryName,
    required super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  factory InventoryCategoryListModel.fromEntity(
    InventoryCategoryListEntity entity,
  ) {
    return InventoryCategoryListModel(
      id: entity.id,
      categoryName: entity.categoryName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  InventoryCategoryListEntity toEntity() {
    return InventoryCategoryListEntity(
      id: id,
      categoryName: categoryName,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  factory InventoryCategoryListModel.fromJson(Map<String, dynamic> json) {
    return InventoryCategoryListModel(
      id: (json['id'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      createdAt: parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: parseDateTime(json['updatedAt']),
      deletedAt: parseDateTime(json['deletedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
  };
}
