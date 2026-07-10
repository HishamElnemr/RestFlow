import 'package:dio/dio.dart';
import '../../../menu/data/models/product_details_model.dart';
import '../../../menu/data/models/product_list_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductListModel>> getProducts({String? search, String? categoryId});
  Future<ProductDetailsModel> getProductDetails(String id);
  Future<String> createProduct(Map<String, dynamic> requestData);
  Future<void> updateProduct(String id, Map<String, dynamic> requestData);
  Future<void> changeProductAvailability(String id, bool isAvailable);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio _dio;

  ProductsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductListModel>> getProducts({String? search, String? categoryId}) async {
    final queryParameters = <String, dynamic>{};
    if (search != null && search.isNotEmpty) queryParameters['search'] = search;
    if (categoryId != null && categoryId.isNotEmpty) queryParameters['categoryId'] = categoryId;

    final response = await _dio.get(
      '/menu/products',
      queryParameters: queryParameters,
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ProductListModel.fromJson(json)).toList();
  }

  @override
  Future<ProductDetailsModel> getProductDetails(String id) async {
    final response = await _dio.get('/menu/products/$id');
    return ProductDetailsModel.fromJson(response.data);
  }

  @override
  Future<String> createProduct(Map<String, dynamic> requestData) async {
    final response = await _dio.post(
      '/menu/products',
      data: requestData,
    );
    return response.data['productId'] as String;
  }

  @override
  Future<void> updateProduct(String id, Map<String, dynamic> requestData) async {
    await _dio.put(
      '/menu/products/$id',
      data: requestData,
    );
  }

  @override
  Future<void> changeProductAvailability(String id, bool isAvailable) async {
    await _dio.patch(
      '/menu/products/$id/availability',
      data: {'isAvailable': isAvailable},
    );
  }
}
