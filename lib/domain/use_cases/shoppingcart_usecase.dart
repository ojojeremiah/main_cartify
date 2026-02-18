import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/repositories/shopping_cart.dart';

class ShoppingCartUseCase {
  final ShoppingCartRepository repository;

  ShoppingCartUseCase(this.repository);

  /// GET CART ITEMS
  Future<(List<Products>?, String)> getCartItems() async {
    try {
      final cartItems = await repository.getCartItems();
      return (cartItems, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// ADD TO CART
  Future<(bool, String)> addToCart(Products product) async {
    try {
      await repository.addItemToCart(product);
      return (true, '');
    } catch (e) {
      return (false, e.toString());
    }
  }

  /// REMOVE FROM CART
  Future<(bool, String)> removeFromCart(Products product) async {
    try {
      await repository.removeItemFromCart(product);
      return (true, '');
    } catch (e) {
      return (false, e.toString());
    }
  }

  /// UPDATE FULL CART LIST
  Future<(bool, String)> updateCartItems(
      List<Products> items) async {
    try {
      await repository.updateCartItems(items);
      return (true, '');
    } catch (e) {
      return (false, e.toString());
    }
  }
}
