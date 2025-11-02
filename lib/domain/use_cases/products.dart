import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/repositories/products.dart';

class ProductUseCase {
  final ProductsRepository productsRepository;

  ProductUseCase(this.productsRepository);

  Future<(List<Products>?, String)> call() async {
    try {
      final productList = await productsRepository.fetchProducts();
      return (productList, "");
    } catch (e) {
      return (null, e.toString());
    }
  }
}
