import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';

class FirebaseAuthUseCases {

  final FirebaseAuthServiceRepository _repository;

  FirebaseAuthUseCases(this._repository);

  Stream<User?> call() {
    return _repository.authStateChanges;
  }


}
