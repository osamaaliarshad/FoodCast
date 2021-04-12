import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodcast/general_providers.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_exception.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signUpWithEmailandPassword(String email, String password);
  Future<void> signInWithEmailandPassword(String email, String password);
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  // Reader allows the AuthRepository to read other providers in the app
  // in this case we need to read firebaseAuth.instance. We will get this from
  // a provider that we will call firebaseAuthProvider. This will be defined
  // in a separate file
  final Reader _read;
  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  Future<void> signInWithEmailandPassword(String email, String password) async {
    try {
      await _read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signUpWithEmailandPassword(String email, String password) async {
    try {
      await _read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
