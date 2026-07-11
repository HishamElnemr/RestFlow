import '../../domain/entities/inventory_item_details_entity.dart';
import 'inventory_parsers.dart';

class InventoryItemDetailsModel extends InventoryItemDetailsEntity {
  const InventoryItemDetailsModel({
    required super.id,
    required super.categoryId,
    required super.itemName,
    required super.categoryName,
    required super.unitOfMeasure,
    required super.currentQuantity,
    required super.minimumQuantity,
    required super.costPerUnit,
    required super.createdAt,
    super.updatedAt,
  });

  factory InventoryItemDetailsModel.fromEntity(
    InventoryItemDetailsEntity entity,
  ) {
    return InventoryItemDetailsModel(
      id: entity.id,
      categoryId: entity.categoryId,
      itemName: entity.itemName,
      categoryName: entity.categoryName,
      unitOfMeasure: entity.unitOfMeasure,
      currentQuantity: entity.currentQuantity,
      minimumQuantity: entity.minimumQuantity,
      costPerUnit: entity.costPerUnit,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  InventoryItemDetailsEntity toEntity() {
    return InventoryItemDetailsEntity(
      id: id,
      categoryId: categoryId,
      itemName: itemName,
      categoryName: categoryName,
      unitOfMeasure: unitOfMeasure,
      currentQuantity: currentQuantity,
      minimumQuantity: minimumQuantity,
      costPerUnit: costPerUnit,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory InventoryItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemDetailsModel(
      id: (json['id'] ?? '').toString(),
      categoryId: (json['categoryId'] ?? '').toString(),
      itemName: (json['itemName'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
      currentQuantity: parseDouble(json['currentQuantity']),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      costPerUnit: parseDouble(json['costPerUnit']),
      createdAt: parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: parseDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'itemName': itemName,
    'categoryName': categoryName,
    'unitOfMeasure': unitOfMeasure,
    'currentQuantity': currentQuantity,
    'minimumQuantity': minimumQuantity,
    'costPerUnit': costPerUnit,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
