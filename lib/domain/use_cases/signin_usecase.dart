import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';

class SignInUseCase {
  final FirebaseAuthServiceRepository _repository;

  SignInUseCase(this._repository);

  Future<User?> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}
