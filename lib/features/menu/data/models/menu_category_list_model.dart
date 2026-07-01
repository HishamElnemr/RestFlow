import '../../domain/entities/menu_category_list_entity.dart';

class MenuCategoryListModel extends MenuCategoryListEntity {
  const MenuCategoryListModel({
    required super.id,
    required super.categoryName,
    super.description,
    required super.displayOrder,
  });

  factory MenuCategoryListModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryListModel(
      id: (json['id'] ?? '').toString(),
      categoryName: (json['categoryName'] ?? '').toString(),
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num? ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
        'description': description,
        'displayOrder': displayOrder,
      };
}
