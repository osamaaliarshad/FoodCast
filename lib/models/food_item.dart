import 'package:flutter/material.dart';

class FoodItem {
  FoodItem({@required this.foodName, this.defaultImage});
  String foodName;
  AssetImage defaultImage = AssetImage('assets/food_images/default.png');
}
