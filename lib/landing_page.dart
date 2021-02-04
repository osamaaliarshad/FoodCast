import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/views/home_page.dart';
import 'package:foodcast/views/login_page.dart';
import 'package:foodcast/views/signup_page.dart';
import 'package:foodcast/providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class LandingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authUser = useProvider(authStateChangeProvider).data?.value;
    if (authUser != null) {
      return MyHomePage();
    } else {
      return LoginScreen();
    }
  }
}
