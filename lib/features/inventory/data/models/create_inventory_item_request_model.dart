import '../../domain/entities/create_inventory_item_request_entity.dart';
import 'inventory_parsers.dart';

class CreateInventoryItemRequestModel extends CreateInventoryItemRequestEntity {
  const CreateInventoryItemRequestModel({
    required super.itemName,
    required super.categoryId,
    required super.unitOfMeasure,
    required super.currentQuantity,
    required super.minimumQuantity,
    required super.costPerUnit,
  });

  factory CreateInventoryItemRequestModel.fromEntity(
    CreateInventoryItemRequestEntity entity,
  ) {
    return CreateInventoryItemRequestModel(
      itemName: entity.itemName,
      categoryId: entity.categoryId,
      unitOfMeasure: entity.unitOfMeasure,
      currentQuantity: entity.currentQuantity,
      minimumQuantity: entity.minimumQuantity,
      costPerUnit: entity.costPerUnit,
    );
  }

  factory CreateInventoryItemRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateInventoryItemRequestModel(
      itemName: (json['itemName'] ?? '').toString(),
      categoryId: (json['categoryId'] ?? '').toString(),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
      currentQuantity: parseDouble(json['currentQuantity']),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      costPerUnit: parseDouble(json['costPerUnit']),
    );
  }

  Map<String, dynamic> toJson() => {
    'itemName': itemName,
    'categoryId': categoryId,
    'unitOfMeasure': unitOfMeasure,
    'currentQuantity': currentQuantity,
    'minimumQuantity': minimumQuantity,
    'costPerUnit': costPerUnit,
  };
}
