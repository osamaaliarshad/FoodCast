import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/presentation/home_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Heebo'),
      home: MyHomePage(),
    );
  }
}
