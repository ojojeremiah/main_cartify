import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main_cartify/domain/use_cases/firebase_auth.dart';
import 'package:main_cartify/domain/use_cases/signin_usecase.dart';
import 'package:main_cartify/domain/use_cases/signout_usevase.dart';
import 'package:main_cartify/domain/use_cases/signup_usecase.dart';

enum AuthDataState { idle, loading, success, error }

class FirebaseAuthServiceProvider extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  final Future<void> Function(String msg) toastFn;

  AuthDataState _state = AuthDataState.idle;
  String _errorMessage = '';
  String _successMessage = '';

  AuthDataState get authState => _state;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  FirebaseAuthServiceProvider(
    this._signInUseCase, this._signUpUseCase, this._signOutUseCase, {
    Future<void> Function(String msg)? toast,
  }) : toastFn = toast ??
            ((msg) async {
              await Fluttertoast.showToast(msg: msg);
            });

  
  void _setLoading() {
    _state = AuthDataState.loading;
    _errorMessage = '';
    notifyListeners();
  }

  void _setSuccess(String message) {
    _state = AuthDataState.success;
    _successMessage = message;
    notifyListeners();
    toastFn(message);
  }

  void _setError(String message) {
    _state = AuthDataState.error;
    _errorMessage = message;
    notifyListeners();
    toastFn(message);
  }

  
  Future<User?> signUp(String email, String password) async {
    try {
      _setLoading();
      final user = await _signUpUseCase.call(email, password);
      _setSuccess('Account created successfully');
      return user;
    } catch (e) {
      _setError('Sign up failed');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      _setLoading();
      final user = await _signInUseCase.call(email, password);
      _setSuccess('Signed in successfully');
      return user;
    } catch (e) {
      _setError('Sign in failed');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading();
      await _signOutUseCase.call();
      _setSuccess('Signed out successfully');
    } catch (e) {
      _setError('Sign out failed');
    }
  }

}
