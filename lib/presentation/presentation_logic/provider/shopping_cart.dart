import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/use_cases/shoppingcart_usecase.dart';

enum CartDataState { idle, loading, success, error }

class ShoppingCartNotifier extends ChangeNotifier {
  final ShoppingCartUseCase shoppingCartUseCase;
  final Future<void> Function({required String msg}) toastFn;

  CartDataState _dataState = CartDataState.idle;
  String _errorMessage = '';
  String _successMessage = '';
  List<Products> _products = [];
  double _total = 0.0;

  CartDataState get cartState => _dataState;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  List<Products> get products => _products;
  double get total => _total;

  ShoppingCartNotifier(
    this.shoppingCartUseCase, {
    Future<void> Function({required String msg})? toast,
  }) : toastFn = toast ?? Fluttertoast.showToast;

  void _setState({
    required CartDataState newState,
    String errorMessage = '',
    String successMessage = '',
  }) {
    _dataState = newState;
    _errorMessage = errorMessage;
    _successMessage = successMessage;
    notifyListeners();
  }

  /// FETCH CART PRODUCTS
  Future<void> fetchProducts() async {
    _setState(newState: CartDataState.loading);

    final result = await shoppingCartUseCase.getCartItems();
    final productsList = result.$1;
    final errorMessage = result.$2;

    if (errorMessage.isNotEmpty) {
      _setState(
        newState: CartDataState.error,
        errorMessage: errorMessage,
      );
      await toastFn(msg: errorMessage);
      return;
    }

    _products = productsList!;
    _calculateTotal(_products);

    _setState(newState: CartDataState.success);
  }

  /// INCREASE PRODUCT QUANTITY / ADD
  Future<void> updateProducts(Products product) async {
    final result = await shoppingCartUseCase.getCartItems();
    final productsList = result.$1;
    final errorMessage = result.$2;

    if (errorMessage.isNotEmpty) {
      await toastFn(msg: errorMessage);
      return;
    }

    try {
      final updatedList = List<Products>.from(productsList!);

      final index =
          updatedList.indexWhere((e) => e.id == product.id);

      if (index != -1) {
        final existingProduct = updatedList[index];

        updatedList[index] = existingProduct.copyWith(
          quantity: (existingProduct.quantity ?? 0) + 1,
        );

        final updateResult =
            await shoppingCartUseCase.updateCartItems(updatedList);

        if (!updateResult.$1) {
          await toastFn(msg: updateResult.$2);
          return;
        }
      } else {
        final addResult =
            await shoppingCartUseCase.addToCart(
              product.copyWith(quantity: 1),
            );

        if (!addResult.$1) {
          await toastFn(msg: addResult.$2);
          return;
        }
      }

      await fetchProducts();
    } catch (e) {
      await toastFn(msg: "Failed to update cart");
    }
  }

  /// DECREASE PRODUCT QUANTITY
  Future<void> deleteProducts(Products product) async {
    final result = await shoppingCartUseCase.getCartItems();
    final productsList = result.$1;
    final errorMessage = result.$2;

    if (errorMessage.isNotEmpty) {
      await toastFn(msg: errorMessage);
      return;
    }

    try {
      final updatedList = List<Products>.from(productsList!);

      final index =
          updatedList.indexWhere((e) => e.id == product.id);

      if (index != -1) {
        final existingProduct = updatedList[index];
        final newQuantity =
            (existingProduct.quantity ?? 0) - 1;

        if (newQuantity <= 0) {
          final removeResult =
              await shoppingCartUseCase.removeFromCart(product);

          if (!removeResult.$1) {
            await toastFn(msg: removeResult.$2);
            return;
          }
        } else {
          updatedList[index] = existingProduct.copyWith(
            quantity: newQuantity,
          );

          final updateResult =
              await shoppingCartUseCase.updateCartItems(updatedList);

          if (!updateResult.$1) {
            await toastFn(msg: updateResult.$2);
            return;
          }
        }
      }

      await fetchProducts();
    } catch (e) {
      await toastFn(msg: "Failed to update cart");
    }
  }

  /// REMOVE ITEM COMPLETELY
  Future<void> removeItem(Products product) async {
    final result =
        await shoppingCartUseCase.removeFromCart(product);

    if (!result.$1) {
      await toastFn(msg: result.$2);
      return;
    }

    await fetchProducts();
  }

  /// CALCULATE TOTAL
  void _calculateTotal(List<Products> data) {
    double newTotal = 0.0;

    for (var item in data) {
      newTotal +=
          (item.price ?? 0) * (item.quantity ?? 0);
    }

    _total = newTotal;
  }
}
