import 'package:rest_flow/features/menu/domain/entities/menu_category_list_entity.dart';
import 'package:rest_flow/features/menu/domain/entities/product_list_entity.dart';

final dummyMenuCategories = [
  const MenuCategoryListEntity(
    id: '1',
    categoryName: 'Pizza',
    displayOrder: 1,
  ),
  const MenuCategoryListEntity(
    id: '2',
    categoryName: 'Pasta',
    displayOrder: 2,
  ),
  const MenuCategoryListEntity(
    id: '3',
    categoryName: 'Salads',
    displayOrder: 3,
  ),
  const MenuCategoryListEntity(
    id: '4',
    categoryName: 'Main Course',
    displayOrder: 4,
  ),
];

final dummyMenuProducts = [
  const ProductListEntity(
    id: '1',
    productName: 'Margherita Pizza',
    categoryName: 'Pizza',
    sellingPrice: 12.99,
    isAvailable: true,
  ),
  const ProductListEntity(
    id: '2',
    productName: 'Pepperoni Pizza',
    categoryName: 'Pizza',
    sellingPrice: 14.99,
    isAvailable: true,
  ),
  const ProductListEntity(
    id: '3',
    productName: 'Pasta Carbonara',
    categoryName: 'Pasta',
    sellingPrice: 15.99,
    isAvailable: true,
  ),
  const ProductListEntity(
    id: '4',
    productName: 'Chicken Tikka Masala',
    categoryName: 'Main Course',
    sellingPrice: 16.99,
    isAvailable: true,
  ),
  const ProductListEntity(
    id: '5',
    productName: 'Caesar Salad',
    categoryName: 'Salads',
    sellingPrice: 8.99,
    isAvailable: true,
  ),
  const ProductListEntity(
    id: '6',
    productName: 'Vegetarian Pizza',
    categoryName: 'Pizza',
    sellingPrice: 13.99,
    isAvailable: false,
  ),
];
