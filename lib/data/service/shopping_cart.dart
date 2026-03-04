import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:main_cartify/data/service/dioclient.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/repositories/shopping_cart.dart';

class ShoppingCartService extends ShoppingCartRepository{
  static final ShoppingCartService _service = ShoppingCartService._internal();
  ShoppingCartService._internal();
  factory ShoppingCartService({required DioClient dioClient}) => _service;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  List<Products> _cartItems = [];

@override
  Future<void> addItemToCart(Products item) async {
    _cartItems.add(item);
    await _saveCart();
  }

  Future<void> _saveCartToStorage(List<Products> items) async {
    log('i am saving to storage...');
    final List<Map<String, dynamic>> cartData =
        items.map((item) => item.toJson()).toList();
    log(jsonEncode(cartData));
    await _storage.write(key: 'Shoppingcart', value: jsonEncode(cartData));
  }

  @override
  Future<void> updateCartItems(List<Products> items) async {
    await _saveCartToStorage(items);
  }

  // @override
  // Future<void> deleteCart(List<Products> items) async {
  //   await _saveCartToStorage(items);
  // }

  @override
  Future<void> removeItemFromCart(Products item) async {
    _cartItems.remove(item);
    await _saveCart();
  }

  @override
  Future<List<Products>> getCartItems() async {
    await _loadCart();
    return _cartItems;
  }

  Future<void> _saveCart() async {
    final List<Map<String, dynamic>> cartData =
        _cartItems.map((item) => item.toJson()).toList();
    await _storage.write(key: 'Shoppingcart', value: jsonEncode(cartData));
  }

  Future<void> _loadCart() async {
    final String? cartDataStr = await _storage.read(key: 'Shoppingcart');
    if (cartDataStr != null) {
      final List<dynamic> cartData = jsonDecode(cartDataStr);
      _cartItems =
          cartData.map((itemJson) => Products.fromJson(itemJson)).toList();
    }
  }  
  
}