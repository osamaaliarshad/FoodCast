import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/services/authentication_service.dart';

final authenticationSeriviceProvider = Provider(
  (ref) => AuthenticationService(FirebaseAuth.instance),
);

final authStateChangeProvider = StreamProvider.autoDispose<User>(
  (ref) => ref.watch(authenticationSeriviceProvider).authStateChanges,
);
