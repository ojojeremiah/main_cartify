import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';

class SignOutUseCase {
  final FirebaseAuthServiceRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() {
    return _repository.signOut();
  }
}
