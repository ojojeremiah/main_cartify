import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthServiceRepository {
  Future<User?> signUp(String email, String password);
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}
