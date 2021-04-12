import 'dart:async';
import 'package:foodcast/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// this class is to keep track of our current user's authentication state
// this class extends a statenotifier of type nullable user. This means that
// the state of our auth controller can be null when the user is not logged in
// or a FireBaseUser if the user is logged in

final authControllerProvider = StateNotifierProvider<AuthController>(
  (ref) => AuthController(ref.read),
);

class AuthController extends StateNotifier<User?> {
  StreamSubscription<User?>? _authStateChangesSubscription;
  final Reader _read;
  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
