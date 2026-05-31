import '../../domain/entities/low_stock_alert_entity.dart';
import 'inventory_parsers.dart';

class LowStockAlertModel extends LowStockAlertEntity {
  const LowStockAlertModel({
    required super.id,
    required super.itemName,
    required super.categoryName,
    required super.currentQuantity,
    required super.minimumQuantity,
    required super.unitOfMeasure,
  });

  factory LowStockAlertModel.fromEntity(LowStockAlertEntity entity) {
    return LowStockAlertModel(
      id: entity.id,
      itemName: entity.itemName,
      categoryName: entity.categoryName,
      currentQuantity: entity.currentQuantity,
      minimumQuantity: entity.minimumQuantity,
      unitOfMeasure: entity.unitOfMeasure,
    );
  }

  LowStockAlertEntity toEntity() {
    return LowStockAlertEntity(
      id: id,
      itemName: itemName,
      categoryName: categoryName,
      currentQuantity: currentQuantity,
      minimumQuantity: minimumQuantity,
      unitOfMeasure: unitOfMeasure,
    );
  }

  factory LowStockAlertModel.fromJson(Map<String, dynamic> json) {
    return LowStockAlertModel(
      id: (json['id'] ?? '').toString(),
      itemName: (json['itemName'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      currentQuantity: parseDouble(json['currentQuantity']),
      minimumQuantity: parseDouble(json['minimumQuantity']),
      unitOfMeasure: (json['unitOfMeasure'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemName': itemName,
    'categoryName': categoryName,
    'currentQuantity': currentQuantity,
    'minimumQuantity': minimumQuantity,
    'unitOfMeasure': unitOfMeasure,
  };
}
