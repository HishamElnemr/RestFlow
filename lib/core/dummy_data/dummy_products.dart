import '../../../features/menu/domain/entities/product_list_entity.dart';

class DummyProducts {
  static final List<ProductListEntity> dummyProducts = List.generate(
    6,
    (index) => ProductListEntity(
      id: 'dummy_product_$index',
      productName: 'Dummy Product $index',
      sellingPrice: 15.99 + index,
      categoryName: 'Dummy Category',
      isAvailable: index % 2 == 0,
    ),
  );
}
