import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodcast/providers/auth_providers.dart';
import 'package:foodcast/views/authentication_views/login_page.dart';
import 'package:foodcast/views/home_page.dart';

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(authStateChangeProvider).when(
      data: (user) => user == null ? LoginScreen() : MyHomePage(),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => LoginScreen(),
    );
  }
}
