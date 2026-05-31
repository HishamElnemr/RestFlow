import '../../domain/entities/inventory_item_response_entity.dart';
import 'inventory_parsers.dart';

class InventoryItemResponseModel extends InventoryItemResponseEntity {
  const InventoryItemResponseModel({
    required super.id,
    required super.itemName,
    required super.categoryName,
    required super.unitOfMeasure,
    required super.currentQuantity,
    required super.minimumQuantity,
    required super.costPerUnit,
    required super.isLowStock,
    required super.isActive,
  });

  factory InventoryItemResponseModel.fromEntity(
    InventoryItemResponseEntity entity,
  ) {
    return InventoryItemResponseModel(
      id: entity.id,
      itemName: entity.itemName,
      categoryName: entity.categoryName,
      unitOfMeasure: entity.unitOfMeasure,
      currentQuantity: entity.currentQuantity,
      minimumQuantity: entity.minimumQuantity,
      costPerUnit: entity.costPerUnit,
      isLowStock: entity.isLowStock,
      isActive: entity.isActive,
    );
  }

  InventoryItemResponseEntity toEntity() {
    return InventoryItemResponseEntity(
      id: id,
      itemName: itemName,
      categoryName: categoryName,
      unitOfMeasure: unitOfMeasure,
      currentQuantity: currentQuantity,
      minimumQuantity: minimumQuantity,
      costPerUnit: costPerUnit,
      isLowStock: isLowStock,
      isActive: isActive,
    );
  }

  factory InventoryItemResponseModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemResponseModel(
      id: (json['id'] ?? '').toString(),
      itemName: (json['itemName'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
      currentQuantity: parseDouble(json['currentQuantity']),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      costPerUnit: parseDouble(json['costPerUnit']),
      isLowStock: json['isLowStock'] == true,
      isActive: json['isActive'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemName': itemName,
    'categoryName': categoryName,
    'unitOfMeasure': unitOfMeasure,
    'currentQuantity': currentQuantity,
    'minimumQuantity': minimumQuantity,
    'costPerUnit': costPerUnit,
    'isLowStock': isLowStock,
    'isActive': isActive,
  };
}
