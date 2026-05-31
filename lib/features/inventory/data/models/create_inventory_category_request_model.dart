import '../../domain/entities/create_inventory_category_request_entity.dart';

class CreateInventoryCategoryRequestModel
    extends CreateInventoryCategoryRequestEntity {
  const CreateInventoryCategoryRequestModel({required super.categoryName});

  factory CreateInventoryCategoryRequestModel.fromEntity(
    CreateInventoryCategoryRequestEntity entity,
  ) {
    return CreateInventoryCategoryRequestModel(
      categoryName: entity.categoryName,
    );
  }

  factory CreateInventoryCategoryRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CreateInventoryCategoryRequestModel(
      categoryName: (json['categoryName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'categoryName': categoryName};
}
