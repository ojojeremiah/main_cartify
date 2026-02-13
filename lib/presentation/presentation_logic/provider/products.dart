import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main_cartify/data/service/error_message.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/use_cases/products.dart';

enum ProductDataState { idle, loading, success, error }

class ProductNotifier extends ChangeNotifier {
  final ProductUseCase productUseCase;
  final Future<void> Function({required String msg}) toastFn;

  ProductDataState _dataState = ProductDataState.idle;
  String _errorMessage = '';
  String _successMessage = '';
  List<Products> _products = [];

  ProductDataState get productState => _dataState;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  List<Products> get products => _products;

  ProductNotifier(
    this.productUseCase, {
    Future<void> Function({required String msg})? toast,
  }) : toastFn = toast ?? Fluttertoast.showToast;

  void _setState({
    required ProductDataState newState,
    String errorMessage = '',
    String successMessage = '',
  }) {
    _dataState = newState;
    _errorMessage = errorMessage;
    _successMessage = successMessage;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _setState(newState: ProductDataState.loading);

    final result = await productUseCase.call();
    _products = result.$1 ?? [];
    final errorMessage = result.$2;

    if (_products.isEmpty) {
      debugPrint('Product fetch error: $errorMessage');

      final userMessage = ErrorMessageHelper.getUserFriendlyMessage(
        errorMessage,
      );

      _setState(newState: ProductDataState.error, errorMessage: userMessage);
      await toastFn(msg: userMessage);
    } else {
      _setState(newState: ProductDataState.success);
    }
  }
}  