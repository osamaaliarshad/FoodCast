import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';

import 'authentication_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authenticationSeriviceProvider = Provider<AuthenticationService>(
    (ref) => AuthenticationService(ref.read(firebaseAuthProvider)));

final authStateChangeProvider = StreamProvider<User>(
    (ref) => ref.watch(authenticationSeriviceProvider).authStateChanges);
