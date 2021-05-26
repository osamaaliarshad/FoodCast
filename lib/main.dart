import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'general_providers.dart';
import 'pages/auth_pages/login_page.dart';
import 'pages/home_page.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: sidebarColor,
      statusBarColor: sidebarColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: sidebarColor, fontFamily: 'Spartan'),
      home: AuthenticationWrapper(),
    );
  }
}

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

// class AuthWrapper extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authControllerState = useProvider(authControllerProvider.state);
//     return Container();
//   }
// }
