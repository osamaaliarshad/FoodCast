import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/providers/auth_providers.dart';
import 'package:foodcast/views/authentication_views/authentication_wrapper.dart';
import 'package:foodcast/views/authentication_views/login_page.dart';
import 'package:foodcast/views/home_page.dart';
import 'constants.dart';

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
      theme: ThemeData(primaryColor: sidebarColor, fontFamily: 'Spartan'),
      home: AuthenticationWrapper(),
    );
  }
}
