import 'package:flutter/material.dart';

class FoodItem {
  FoodItem({@required this.foodName, this.imageAsset});
  String foodName;
  AssetImage imageAsset = AssetImage('assets/food_images/default.png');
}
