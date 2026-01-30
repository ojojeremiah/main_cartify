import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';

class SignUpUseCase {
  final FirebaseAuthServiceRepository _repository;

  SignUpUseCase(this._repository);

  Future<User?> call(String email, String password) {
    return _repository.signUp(email, password);
  }
}
