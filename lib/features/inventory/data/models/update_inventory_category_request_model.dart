import '../../domain/entities/update_inventory_category_request_entity.dart';

class UpdateInventoryCategoryRequestModel
    extends UpdateInventoryCategoryRequestEntity {
  const UpdateInventoryCategoryRequestModel({required super.categoryName});

  factory UpdateInventoryCategoryRequestModel.fromEntity(
    UpdateInventoryCategoryRequestEntity entity,
  ) {
    return UpdateInventoryCategoryRequestModel(
      categoryName: entity.categoryName,
    );
  }

  factory UpdateInventoryCategoryRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateInventoryCategoryRequestModel(
      categoryName: (json['categoryName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'categoryName': categoryName};
}
