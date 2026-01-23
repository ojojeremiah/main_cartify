import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';

class FirebaseAuthUseCases {
  final FirebaseAuthServiceRepository _authService;

  FirebaseAuthUseCases(this._authService);

  Future<User?> signUp(String email, String password) {
    return _authService.signUp(email, password);
  }

  Future<User?> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }

  Stream<User?> get authStateChanges {
    return _authService.authStateChanges;
  }
}
