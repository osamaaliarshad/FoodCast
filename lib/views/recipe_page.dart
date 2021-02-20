import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/providers/database_providers.dart';
import 'package:foodcast/views/food_list.dart';

class RecipePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Expanded(
      child: Center(
        child: Text('foods'),
      ),
    );
  }
}

Card createStyleCard(String food, String image) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/food_images/$image'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.3),
            child: Text(
              food,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.0, color: Colors.white, fontFamily: 'Raleway'),
            ),
          ),
        ),
      ),
    ),
  );
}
