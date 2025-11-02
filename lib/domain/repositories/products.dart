import 'package:main_cartify/domain/model/products.dart';

abstract class ProductsRepository {
  Future<List<Products>> fetchProducts();
}