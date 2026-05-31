import '../../domain/entities/update_inventory_item_request_entity.dart';
import 'inventory_parsers.dart';

class UpdateInventoryItemRequestModel extends UpdateInventoryItemRequestEntity {
  const UpdateInventoryItemRequestModel({
    required super.categoryId,
    required super.itemName,
    required super.unitOfMeasure,
    required super.minimumQuantity,
    required super.costPerUnit,
  });

  factory UpdateInventoryItemRequestModel.fromEntity(
    UpdateInventoryItemRequestEntity entity,
  ) {
    return UpdateInventoryItemRequestModel(
      categoryId: entity.categoryId,
      itemName: entity.itemName,
      unitOfMeasure: entity.unitOfMeasure,
      minimumQuantity: entity.minimumQuantity,
      costPerUnit: entity.costPerUnit,
    );
  }

  factory UpdateInventoryItemRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateInventoryItemRequestModel(
      categoryId: (json['categoryId'] ?? '').toString(),
      itemName: (json['itemName'] ?? '').toString(),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      costPerUnit: parseDouble(json['costPerUnit']),
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'itemName': itemName,
    'unitOfMeasure': unitOfMeasure,
    'minimumQuantity': minimumQuantity,
    'costPerUnit': costPerUnit,
  };
}
