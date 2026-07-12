import '../../features/menu/domain/entities/menu_category_list_entity.dart';

final List<MenuCategoryListEntity> dummyMenuCategories = [
  const MenuCategoryListEntity(
    id: '1',
    categoryName: 'Main Dishes',
    description: 'Traditional Egyptian Main Meals',
    displayOrder: 1,
  ),
  const MenuCategoryListEntity(
    id: '2',
    categoryName: 'Appetizers & Sides',
    description: 'Delicious sides, salads and appetizers',
    displayOrder: 2,
  ),
  const MenuCategoryListEntity(
    id: '3',
    categoryName: 'Desserts',
    description: 'Traditional Egyptian sweet treats',
    displayOrder: 3,
  ),
  const MenuCategoryListEntity(
    id: '4',
    categoryName: 'Beverages',
    description: 'Cold and hot drinks',
    displayOrder: 4,
  ),
];
