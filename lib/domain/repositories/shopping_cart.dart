import 'package:main_cartify/domain/model/products.dart';

abstract class ShoppingCartRepository {
  Future<List<Products>> getCartItems();
  Future<void> addItemToCart(Products product);
  Future<void> updateCartItems(List<Products> items);
  Future<void> removeItemFromCart(Products product);
}
