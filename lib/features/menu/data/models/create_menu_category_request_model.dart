import '../../domain/entities/create_menu_category_request_entity.dart';

class CreateMenuCategoryRequestModel extends CreateMenuCategoryRequestEntity {
  const CreateMenuCategoryRequestModel({
    super.categoryName,
    super.description,
    super.displayOrder,
  });

  factory CreateMenuCategoryRequestModel.fromEntity(
    CreateMenuCategoryRequestEntity entity,
  ) {
    return CreateMenuCategoryRequestModel(
      categoryName: entity.categoryName,
      description: entity.description,
      displayOrder: entity.displayOrder,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categoryName != null) map['categoryName'] = categoryName;
    if (description != null) map['description'] = description;
    if (displayOrder != null) map['displayOrder'] = displayOrder;
    return map;
  }
}
