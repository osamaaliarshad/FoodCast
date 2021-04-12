import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// provides an instance of firebase auth
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// this provider will be used to CRUD
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authStateChangeProvider = StreamProvider.autoDispose<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);
