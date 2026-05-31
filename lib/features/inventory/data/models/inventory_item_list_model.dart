import '../../domain/entities/inventory_item_list_entity.dart';
import 'inventory_parsers.dart';

class InventoryItemListModel extends InventoryItemListEntity {
  const InventoryItemListModel({
    required super.id,
    required super.itemName,
    required super.categoryName,
    required super.unitOfMeasure,
    required super.currentQuantity,
    required super.minimumQuantity,
    required super.costPerUnit,
    required super.isLowStock,
  });

  factory InventoryItemListModel.fromEntity(InventoryItemListEntity entity) {
    return InventoryItemListModel(
      id: entity.id,
      itemName: entity.itemName,
      categoryName: entity.categoryName,
      unitOfMeasure: entity.unitOfMeasure,
      currentQuantity: entity.currentQuantity,
      minimumQuantity: entity.minimumQuantity,
      costPerUnit: entity.costPerUnit,
      isLowStock: entity.isLowStock,
    );
  }

  InventoryItemListEntity toEntity() {
    return InventoryItemListEntity(
      id: id,
      itemName: itemName,
      categoryName: categoryName,
      unitOfMeasure: unitOfMeasure,
      currentQuantity: currentQuantity,
      minimumQuantity: minimumQuantity,
      costPerUnit: costPerUnit,
      isLowStock: isLowStock,
    );
  }

  factory InventoryItemListModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemListModel(
      id: (json['id'] ?? '').toString(),
      itemName: (json['itemName'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
      currentQuantity: parseDouble(json['currentQuantity']),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      costPerUnit: parseDouble(json['costPerUnit']),
      isLowStock: json['isLowStock'] == true,
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
  };
}
