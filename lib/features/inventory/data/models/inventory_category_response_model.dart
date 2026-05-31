import '../../domain/entities/inventory_category_response_entity.dart';
import 'inventory_parsers.dart';

class InventoryCategoryResponseModel extends InventoryCategoryResponseEntity {
  const InventoryCategoryResponseModel({
    required super.id,
    required super.categoryName,
    required super.createdAt,
    super.updatedAt,
  });

  factory InventoryCategoryResponseModel.fromEntity(
    InventoryCategoryResponseEntity entity,
  ) {
    return InventoryCategoryResponseModel(
      id: entity.id,
      categoryName: entity.categoryName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  InventoryCategoryResponseEntity toEntity() {
    return InventoryCategoryResponseEntity(
      id: id,
      categoryName: categoryName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory InventoryCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return InventoryCategoryResponseModel(
      id: (json['id'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      createdAt: parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: parseDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
