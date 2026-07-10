import '../../features/inventory/domain/entities/inventory_item_list_entity.dart';

class DummyInventoryItems {
  static const List<InventoryItemListEntity> items = [
    InventoryItemListEntity(
      id: '1',
      itemName: 'Flour (All Purpose)',
      categoryName: 'Ingredients',
      unitOfMeasure: 'Kg',
      currentQuantity: 15.5,
      minimumQuantity: 5.0,
      costPerUnit: 12.0,
      isLowStock: false,
    ),
    InventoryItemListEntity(
      id: '2',
      itemName: 'Sugar',
      categoryName: 'Ingredients',
      unitOfMeasure: 'Kg',
      currentQuantity: 2.0,
      minimumQuantity: 10.0,
      costPerUnit: 15.0,
      isLowStock: true,
    ),
    InventoryItemListEntity(
      id: '3',
      itemName: 'Olive Oil',
      categoryName: 'Liquids',
      unitOfMeasure: 'Liters',
      currentQuantity: 8.0,
      minimumQuantity: 5.0,
      costPerUnit: 45.0,
      isLowStock: false,
    ),
    InventoryItemListEntity(
      id: '4',
      itemName: 'Salt',
      categoryName: 'Ingredients',
      unitOfMeasure: 'Kg',
      currentQuantity: 1.0,
      minimumQuantity: 2.0,
      costPerUnit: 5.0,
      isLowStock: true,
    ),
  ];
}
