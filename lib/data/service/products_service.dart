import 'package:main_cartify/data/service/dioclient.dart';
import 'package:main_cartify/data/service/endpoints.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/repositories/products.dart';

List<Products> products = [];

class ProductService extends ProductsRepository{
  final DioClient dioClient;

  ProductService({required this.dioClient});

  @override
  Future<List<Products>> fetchProducts() async {
    try {
      final response = await dioClient.get(Endpoints.allProducts);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Products.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}